//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DHSpawnManager extends SVehicleFactory;

enum ESpawnPointType
{
    ESPT_Infantry,
    ESPT_Vehicles
};

enum ESpawnPointMethod
{
    ESPM_Hints,
    ESPM_Radius
};

struct VehiclePool
{
    var() name              Tag;
    var() class<ROVehicle>  VehicleClass;
    var() bool              bIsInitiallyActive;
    var() float             RespawnTime;                //respawn interval in seconds
    var() byte              MaxSpawns;                  //how many vehicles can be spawned from this pool
    var() byte              MaxActive;                  //how many vehicles from this pool can be active at once

    var() name              OnActivatedEvent;           //event to trigger when pool is activated (also gets triggered when initially activated)
    var() name              OnDeactivatedEvent;         //event to trigger when pool is deactivated (does NOT get triggered when initially deactivated)
    var() name              OnDepletedEvent;            //event to trigger when pool has been depleted (SpawnCount meets or exceeds MaxSpawns)
    var() name              OnVehicleDestroyedEvent;    //event to trigger when vehicle from this pool is destroyed
    var() name              OnVehicleSpawnedEvent;      //event to trigger when vehicle from this pool is spawned

    var bool                bIsActive;
    var float               NextAvailableTime;          //the next time a vehicle from this pool can be spawned
    var byte                SpawnCount;                 //count of vehicles spawned from this pool
    var byte                ActiveCount;                //count of active vehicles spawn from this pool
};

var const byte SpawnError_None;
var const byte SpawnError_Fatal;
var const byte SpawnError_MaxVehicles;
var const byte SpawnError_Cooldown;
var const byte SpawnError_SpawnLimit;
var const byte SpawnError_ActiveLimit;
var const byte SpawnError_PoolInactive;
var const byte SpawnError_SpawnInactive;
var const byte SpawnError_Blocked;
var const byte SpawnError_Failed;
var const byte SpawnError_BadTeamPool;
var const byte SpawnError_BadTeamSpawnPoint;
var const byte SpawnError_TryToDriveFailed;
var const byte SpawnError_BadSpawnType;
var const byte SpawnError_PawnSpawnFailed;

var const byte SpawnPointType_Infantry;
var const byte SpawnPointType_Vehicles;

var localized array<string> SpawnErrorStrings;

const SpawnPointsMax = 32;
const PoolsMax = 32;

var(Vehicles) array<VehiclePool>        VehiclePools;
var(Vehicles) byte                      MaxTeamVehicles[2];
var(Vehicles) byte                      MaxDestroyedVehicles;

var class<LocalMessage>                 VehicleDestroyedMessageClass;

var private byte                        TeamVehicleCounts[2];
var private array<ROVehicle>            Vehicles;
var private array<DHSpawnPoint>         SpawnPoints;
var private DHGameReplicationInfo       GRI;
var private config bool                 bDebug;

function PostBeginPlay()
{
    local byte i;
    local DHSpawnPoint SP;

    super.PostBeginPlay();

    GRI = DHGameReplicationInfo(Level.Game.GameReplicationInfo);

    if (GRI == none)
    {
        Warn("DHGameReplicationInfo is none");

        return;
    }

    foreach AllActors(class'DHSpawnPoint', SP)
    {
        if (SpawnPoints.Length >= SpawnPointsMax)
        {
            Warn("DHSpawnPoint count exceeds" @ SpawnPointsMax);

            break;
        }

        SpawnPoints[SpawnPoints.Length] = SP;
    }

    Log("Spawn points length = " @ SpawnPoints.Length);

    //Update GameReplicationInfo
    for (i = 0; i < SpawnPoints.Length; ++i)
    {
        UpdateSpawnPointReplicationInfo(i);
    }

    for (i = 0; i < VehiclePools.Length; ++i)
    {
        SetPoolIsActive(i, VehiclePools[i].bIsInitiallyActive);

        UpdatePoolReplicationInfo(i);
    }

    //TODO: verify uniqueness of VehicleClass in VehiclePools
}

function Reset()
{
    Vehicles.Length = 0;

    super.Reset();
}

function UpdateSpawnPointReplicationInfo(byte SpawnPointIndex)
{
    GRI.SetSpawnPointIsActive(SpawnPointIndex, SpawnPoints[SpawnPointIndex].bIsActive);
    GRI.SetSpawnPointTeamIndex(SpawnPointIndex, SpawnPoints[SpawnPointIndex].TeamIndex);
}

function UpdatePoolReplicationInfo(byte PoolIndex)
{
    GRI.SetVehiclePoolVehicleClass(PoolIndex, VehiclePools[PoolIndex].VehicleClass);
    GRI.SetVehiclePoolIsActive(PoolIndex, VehiclePools[PoolIndex].bIsActive);
    GRI.SetVehiclePoolSpawnsRemaining(PoolIndex, GetPoolSpawnsRemaining(PoolIndex));
    GRI.SetVehiclePoolNextAvailableTime(PoolIndex, VehiclePools[PoolIndex].NextAvailableTime);
}

function DrySpawnVehicle(DHPlayer C, out vector SpawnLocation, out rotator SpawnRotation, out byte SpawnError)
{
    local DHSpawnPoint SP;

    SpawnError = SpawnError_Fatal;

    if (C == none)
    {
        return;
    }

    //Check spawn point
    SpawnError = GetSpawnPointError(C, ESPT_Vehicles);

    if (SpawnError != SpawnError_None)
    {
        return;
    }

    SP = SpawnPoints[C.SpawnPointIndex];

    if (SP == none)
    {
        SpawnError = SpawnError_Fatal;

        return;
    }

    //Check vehicle pool
    SpawnError = GetVehiclePoolError(C, SP);

    if (SpawnError != SpawnError_None)
    {
        return;
    }

    switch (SP.Method)
    {
        case ESPM_Hints:
            if (!GetSpawnLocation(SP, VehiclePools[C.VehiclePoolIndex].VehicleClass.default.CollisionRadius * 1.25, SpawnLocation, SpawnRotation))
            {
                SpawnError = SpawnError_Blocked;

                return;
            }
        case ESPM_Radius:
            //TODO: do a proper radius check
            SpawnLocation = SP.Location;
            SpawnRotation = SP.Rotation;
    }

    SpawnError = SpawnError_None;
}

function bool GetSpawnLocation(DHSpawnPoint SP, float CollisionRadius, out vector SpawnLocation, out rotator SpawnRotation)
{
    local Pawn P;
    local array<int> LocationHintIndices;
    local int LocationHintIndex;
    local int i;
    local bool bIsBlocked;

    //Scramble location hint indices so we don't use the same ones repeatedly
    LocationHintIndices = CreateScrambledArrayIndices(SP.LocationHints.Length);

    //Initialize with invalid index
    LocationHintIndex = -1;

    for (i = 0; i < LocationHintIndices.Length; ++i)
    {
        bIsBlocked = false;

        foreach RadiusActors(class'Pawn', P, CollisionRadius , SP.LocationHints[LocationHintIndices[i]].Location)
        {
            //Found a blocking actor
            bIsBlocked = true;

            break;
        }

        if (!bIsBlocked)
        {
            //Location hint not blocked
            LocationHintIndex = LocationHintIndices[i];

            break;
        }
    }

    if (LocationHintIndex == -1)
    {
        //No usable location hint found
        return false;
    }

    SpawnLocation = SP.LocationHints[LocationHintIndex].Location;
    SpawnRotation = SP.LocationHints[LocationHintIndex].Rotation;

    return true;
}

function SpawnPlayer(DHPlayer C, out byte SpawnError)
{
    if (C == none)
    {
        return;
    }

    if (C.VehiclePoolIndex != -1)
    {
        Log("attempting to spawn vehicle at VP" @ C.VehiclePoolIndex @ "SP" @ C.SpawnPointIndex);

        SpawnVehicle(C, SpawnError);
    }
    else
    {
        Log("attempting to spawn infantry at SP" @ C.SpawnPointIndex);

        SpawnInfantry(C, SpawnError);
    }
}

function ROVehicle SpawnVehicle(DHPlayer C, out byte SpawnError)
{
    local ROVehicle V;
    local vector SpawnLocation;
    local rotator SpawnRotation;

    //TODO: need to check desired role etc.

    SpawnError = SpawnError_Fatal;

    if (C == none || C.Pawn != none)
    {
        return none;
    }

    DrySpawnVehicle(C, SpawnLocation, SpawnRotation, SpawnError);

    if (SpawnError != SpawnError_None)
    {
        return none;
    }

    V = Spawn(VehiclePools[C.VehiclePoolIndex].VehicleClass,,, SpawnLocation, SpawnRotation);

    if (V == none)
    {
        SpawnError = SpawnError_Failed;

        return none;
    }

    //Spawn a player
    SpawnPawn(C, SpawnLocation, SpawnRotation);

    //TODO: spawn the player somewhere way out in left field!
    if (C.Pawn == none || !V.TryToDrive(C.Pawn))
    {
        V.Destroy();

        SpawnError = SpawnError_TryToDriveFailed;
    }
    else
    {
        //ParentFactory must be set after any calls to Destroy are made so that
        //VehicleDestroyed is not called in the event that TryToDrive fails
        V.ParentFactory = self;

        //Add vehicle to vehicles array
        Vehicles[Vehicles.Length] = V;

        //Increment team vehicle count
        ++TeamVehicleCounts[V.default.VehicleTeam];

        //Update pool properties
        SetPoolNextAvailableTime(C.VehiclePoolIndex, Level.TimeSeconds + VehiclePools[C.VehiclePoolIndex].RespawnTime);
        SetPoolActiveCount(C.VehiclePoolIndex, VehiclePools[C.VehiclePoolIndex].ActiveCount + 1);
        SetPoolSpawnCount(C.VehiclePoolIndex, VehiclePools[C.VehiclePoolIndex].SpawnCount + 1);

        if (VehiclePools[C.VehiclePoolIndex].OnVehicleSpawnedEvent != '')
        {
            //Trigger OnVehicleSpawned event
            TriggerEvent(VehiclePools[C.VehiclePoolIndex].OnVehicleSpawnedEvent, none, none);
        }
    }

    return V;
}

function Pawn SpawnPawn(Controller C, vector SpawnLocation, rotator SpawnRotation)
{
    local DarkestHourGame G;
    local class<Pawn> DefaultPlayerClass;

    G = DarkestHourGame(Level.Game);

    if (G != none && C.PreviousPawnClass != none && C.PawnClass != C.PreviousPawnClass)
    {
        G.BaseMutator.PlayerChangedClass(C);
    }

    if (C.PawnClass != none)
    {
        C.Pawn = Spawn(C.PawnClass,,, SpawnLocation, SpawnRotation);
    }

    if (C.Pawn == none)
    {
        DefaultPlayerClass = DarkestHourGame(Level.Game).GetDefaultPlayerClass(C);

        C.Pawn = Spawn(DefaultPlayerClass,,, SpawnLocation, SpawnRotation);
    }

    if (C.Pawn == none)
    {
        Log("Couldn't spawn player of type" @ C.PawnClass @ "at" @ SpawnLocation);

        C.GotoState('Dead');

        if (PlayerController(C) != none)
        {
            PlayerController(C).ClientGotoState('Dead', 'Begin');
        }

        return none;
    }

    if (PlayerController(C) != none)
    {
        PlayerController(C).TimeMargin = -0.1;
    }

    C.Pawn.LastStartTime = Level.TimeSeconds;
    C.PreviousPawnClass = C.Pawn.Class;
    C.Possess(C.Pawn);
    C.PawnClass = C.Pawn.Class;
    C.Pawn.PlayTeleportEffect(true, true);
    C.ClientSetRotation(C.Pawn.Rotation);

    DarkestHourGame(Level.Game).AddDefaultInventory(C.Pawn);

    return C.Pawn;
}

function byte GetSpawnPointError(DHPlayer C, ESpawnPointType SpawnPointType)
{
    local DHSpawnPoint SP;

    if (C.SpawnPointIndex < 0 || C.SpawnPointIndex >= SpawnPoints.Length)
    {
        Error("[DHSM] Fatal error in DrySpawnInfantry (either invalid indices passed in or pool's VehicleClass is none)");

        return SpawnError_Fatal;
    }

    SP = SpawnPoints[C.SpawnPointIndex];

    if (SP == none || SP.Type != SpawnPointType)
    {
        Error("[DHSM] Fatal error, requested spawn point is null or incorrect type");

        return SpawnError_Fatal;
    }

    if (C.GetTeamNum() != SP.TeamIndex)
    {
        Error("[DHSM] Spawn point team index (" $ SP.TeamIndex $ ") does not match player's (" $ C.GetTeamNum() $ ")");

        return SpawnError_BadTeamSpawnPoint;
    }

    if (!SP.bIsActive)
    {
        Error("[DHSM] Spawn point" @ C.SpawnPointIndex @ "is inactive");

        return SpawnError_SpawnInactive;
    }

    if (SP.Type != SpawnPointType)
    {
        return SpawnError_SpawnInactive;
    }

    return SpawnError_None;
}

function byte GetVehiclePoolError(DHPlayer C, DHSpawnPoint SP)
{
    if (C == none)
    {
        return SpawnError_Fatal;
    }

    if (C.VehiclePoolIndex < 0 || C.VehiclePoolIndex >= PoolsMax || VehiclePools[C.VehiclePoolIndex].VehicleClass == none)
    {
        Error("[DHSM] Fatal error in DrySpawn (either invalid indices passed in or pool's VehicleClass is none)");

        return SpawnError_Fatal;
    }

    if (SP == none || SP.Type != ESPT_Vehicles)
    {
        Error("[DHSM] Fatal error, requested spawn point is null or incorrect type");

        return SpawnError_Fatal;
    }

    if (TeamVehicleCounts[VehiclePools[C.VehiclePoolIndex].VehicleClass.default.VehicleTeam] >= MaxTeamVehicles[VehiclePools[C.VehiclePoolIndex].VehicleClass.default.VehicleTeam])
    {
        Error("[DHSM] Max vehicles (" $ MaxTeamVehicles[VehiclePools[C.VehiclePoolIndex].VehicleClass.default.VehicleTeam] $ ") reached for team" @ VehiclePools[C.VehiclePoolIndex].VehicleClass.default.VehicleTeam);

        return SpawnError_MaxVehicles;
    }

    if (!VehiclePools[C.VehiclePoolIndex].bIsActive)
    {
        Error("[DHSM]" @ VehiclePools[C.VehiclePoolIndex].VehicleClass @ "pool is inactive");

        return SpawnError_PoolInactive;
    }

    if (Level.TimeSeconds < VehiclePools[C.VehiclePoolIndex].NextAvailableTime)
    {
        Error("[DHSM] Cooldown on" @ VehiclePools[C.VehiclePoolIndex].VehicleClass @ "pool:" @ VehiclePools[C.VehiclePoolIndex].NextAvailableTime - Level.TimeSeconds);

        return SpawnError_Cooldown;
    }

    if (VehiclePools[C.VehiclePoolIndex].SpawnCount >= VehiclePools[C.VehiclePoolIndex].MaxSpawns)
    {
        Error("[DHSM]" @ VehiclePools[C.VehiclePoolIndex].VehicleClass @ "pool is at max spawns (" $ VehiclePools[C.VehiclePoolIndex].MaxSpawns $ ")");

        return SpawnError_SpawnLimit;
    }

    if (VehiclePools[C.VehiclePoolIndex].ActiveCount >= VehiclePools[C.VehiclePoolIndex].MaxActive)
    {
        Error("[DHSM]" @ VehiclePools[C.VehiclePoolIndex].VehicleClass @ "pool is at active limit (" $ VehiclePools[C.VehiclePoolIndex].MaxActive $ ")");

        return SpawnError_ActiveLimit;
    }

    return SpawnError_None;
}

function DrySpawnInfantry(DHPlayer C, out vector SpawnLocation, out rotator SpawnRotation, out byte SpawnError)
{
    local DHSpawnPoint SP;

    SpawnError = SpawnError_Fatal;

    if (C == none)
    {
        return;
    }

    //Spawn point sanity check
    SpawnError = GetSpawnPointError(C, ESPT_Infantry);

    if (SpawnError != SpawnError_None)
    {
        return;
    }

    SP = SpawnPoints[C.SpawnPointIndex];

    if (SP == none)
    {
        SpawnError = SpawnError_Fatal;

        return;
    }

    switch (SP.Method)
    {
        case ESPM_Hints:
            if (!GetSpawnLocation(SP, class'DH_Pawn'.default.CollisionRadius, SpawnLocation, SpawnRotation))
            {
                SpawnError = SpawnError_Blocked;

                return;
            }

            break;
        case ESPM_Radius:
            SpawnLocation = SP.Location;
            SpawnRotation = SP.Rotation;

            break;
    }

    SpawnError = SpawnError_None;
}

function SpawnInfantry(DHPlayer C, out byte SpawnError)
{
    local Pawn P;
    local vector SpawnLocation;
    local rotator SpawnRotation;

    SpawnError = SpawnError_Fatal;

    if (C == none || C.Pawn != none)
    {
        return;
    }

    DrySpawnInfantry(C, SpawnLocation, SpawnRotation, SpawnError);

    if (SpawnError != SpawnError_None)
    {
        return;
    }

    P = SpawnPawn(C, SpawnLocation, SpawnRotation);

    if (P == none)
    {
        SpawnError = SpawnError_PawnSpawnFailed;

        return;
    }

    SpawnError = SpawnError_None;
}

event VehicleDestroyed(Vehicle V)
{
    local int i;
    local Controller C;

    super.VehicleDestroyed(V);

    //Removes the destroyed vehicle from the managed vehicles
    for (i = Vehicles.Length - 1; i >= 0; --i)
    {
        if (V == Vehicles[i])
        {
            //Remove vehicle from vehicles array
            Vehicles.Remove(i, 1);

            //Decrement team vehicle count
            --TeamVehicleCounts[ROVehicle(V).default.VehicleTeam];

            break;
        }
    }

    //Removes 1 from the count of vehicles in the pool
    for (i = 0; i < VehiclePools.Length; ++i)
    {
        if (V.class == VehiclePools[i].VehicleClass)
        {
            SetPoolActiveCount(i, VehiclePools[i].ActiveCount - 1);

            if (!IsPoolInfinite(i))
            {
                for (C = Level.ControllerList; C != none; C = C.NextController)
                {
                    if (C.GetTeamNum() == VehiclePools[i].VehicleClass.default.VehicleTeam)
                    {
                        C.BroadcastLocalizedMessage(VehicleDestroyedMessageClass,,,, V);
                    }
                }
            }

            if (VehiclePools[i].OnVehicleDestroyedEvent != '')
            {
                TriggerEvent(VehiclePools[i].OnVehicleDestroyedEvent, none, none);
            }

            if (VehiclePools[i].OnDepletedEvent != '' && GetPoolSpawnsRemaining(i) == 0)
            {
                TriggerEvent(VehiclePools[i].OnDepletedEvent, none, none);
            }

            break;
        }
    }
}

//==============================================================================
// Spawn Point Functions
//==============================================================================

private function GetSpawnPointIndicesByTag(name SpawnPointTag, out array<byte> SpawnPointIndices)
{
    local int i;

    for (i = 0; i < SpawnPoints.Length; ++i)
    {
        if (SpawnPoints[i].Tag == SpawnPointTag)
        {
            SpawnPointIndices[SpawnPointIndices.Length] = i;
        }
    }
}

private function SetSpawnPointIsActive(int SpawnPointIndex, bool bIsActive)
{
    SpawnPoints[SpawnPointIndex].bIsActive = bIsActive;
    GRI.SetSpawnPointIsActive(SpawnPointIndex, bIsActive);
}

function SetSpawnPointIsActiveByTag(name SpawnPointTag, bool bIsActive)
{
    local int i;
    local array<byte> SpawnPointIndices;

    GetSpawnPointIndicesByTag(SpawnPointTag, SpawnPointIndices);

    for (i = 0; i < SpawnPointIndices.Length; ++i)
    {
        SetSpawnPointIsActive(SpawnPointIndices[i], bIsActive);
    }
}

function ToggleSpawnPointIsActiveByTag(name SpawnPointTag)
{
    local int i;
    local array<byte> SpawnPointIndices;

    GetSpawnPointIndicesByTag(SpawnPointTag, SpawnPointIndices);

    for (i = 0; i < SpawnPointIndices.Length; ++i)
    {
        SetSpawnPointIsActive(SpawnPointIndices[i], !SpawnPoints[SpawnPointIndices[i]].bIsActive);
    }
}

//==============================================================================
// Pool Functions
//==============================================================================

private function GetPoolIndicesByTag(name PoolTag, out array<byte> PoolIndices)
{
    local int i;

    for (i = 0; i < VehiclePools.Length; ++i)
    {
        if (VehiclePools[i].Tag == PoolTag)
        {
            PoolIndices[PoolIndices.Length] = i;
        }
    }
}

private function SetPoolNextAvailableTime(byte PoolIndex, float NextAvailableTime)
{
    VehiclePools[PoolIndex].NextAvailableTime = NextAvailableTime;
    GRI.SetVehiclePoolNextAvailableTime(PoolIndex, NextAvailableTime);
}

private function SetPoolActiveCount(byte PoolIndex, byte ActiveCount)
{
    VehiclePools[PoolIndex].ActiveCount = ActiveCount;
    GRI.SetVehiclePoolActiveCount(PoolIndex, ActiveCount);
}

private function byte GetPoolSpawnsRemaining(byte PoolIndex)
{
    return VehiclePools[PoolIndex].MaxSpawns - VehiclePools[PoolIndex].SpawnCount;
}

private function SetPoolSpawnCount(byte PoolIndex, byte SpawnCount)
{
    VehiclePools[PoolIndex].SpawnCount = SpawnCount;
    GRI.SetVehiclePoolSpawnsRemaining(PoolIndex, GetPoolSpawnsRemaining(PoolIndex));
}

private function SetPoolMaxSpawns(byte PoolIndex, byte MaxSpawns)
{
    VehiclePools[PoolIndex].MaxSpawns = MaxSpawns;
    GRI.SetVehiclePoolSpawnsRemaining(PoolIndex, GetPoolSpawnsRemaining(PoolIndex));
}

private function SetPoolMaxActive(byte PoolIndex, byte MaxActive)
{
    VehiclePools[PoolIndex].MaxActive = MaxActive;
    GRI.SetVehiclePoolMaxActives(PoolIndex, VehiclePools[PoolIndex].MaxActive);
}

private function AddPoolMaxActive(byte PoolIndex, int Value)
{
    VehiclePools[PoolIndex].MaxActive += Value;
    GRI.SetVehiclePoolMaxActives(PoolIndex, VehiclePools[PoolIndex].MaxActive);
}

private function AddPoolMaxSpawns(byte PoolIndex, int Value)
{
    VehiclePools[PoolIndex].MaxSpawns += Value;
    GRI.SetVehiclePoolSpawnsRemaining(PoolIndex, GetPoolSpawnsRemaining(PoolIndex));
}

private function SetPoolIsActive(int PoolIndex, bool bIsActive)
{
    if (VehiclePools[PoolIndex].bIsActive == bIsActive)
    {
        //no change
        return;
    }

    VehiclePools[PoolIndex].bIsActive = bIsActive;
    GRI.SetVehiclePoolIsActive(PoolIndex, bIsActive);

    if (bIsActive)
    {
        if (VehiclePools[PoolIndex].OnActivatedEvent != '')
        {
            TriggerEvent(VehiclePools[PoolIndex].OnActivatedEvent, none, none);
        }
    }
    else
    {
        if (VehiclePools[PoolIndex].OnDeactivatedEvent != '')
        {
            TriggerEvent(VehiclePools[PoolIndex].OnDeactivatedEvent, none, none);
        }
    }
}

function AddPoolMaxSpawnsByTag(name PoolTag, int Value)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        AddPoolMaxSpawns(PoolIndices[i], Value);
    }
}

function SetPoolMaxSpawnsByTag(name PoolTag, byte MaxSpawns)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        SetPoolMaxSpawns(PoolIndices[i], MaxSpawns);
    }
}

function AddPoolMaxActiveByTag(name PoolTag, int Value)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        AddPoolMaxActive(PoolIndices[i], Value);
    }
}

function SetPoolMaxActiveByTag(name PoolTag, byte Value)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        SetPoolMaxActive(PoolIndices[i], Value);
    }
}

function SetPoolIsActiveByTag(name PoolTag, bool bIsActive)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        SetPoolIsActive(PoolIndices[i], bIsActive);
    }
}

function TogglePoolIsActiveByTag(name PoolTag)
{
    local int i;
    local array<byte> PoolIndices;

    GetPoolIndicesByTag(PoolTag, PoolIndices);

    for (i = 0; i < PoolIndices.Length; ++i)
    {
        SetPoolIsActive(PoolIndices[i], !VehiclePools[PoolIndices[i]].bIsActive);
    }
}

function bool IsPoolInfinite(byte PoolIndex)
{
    return VehiclePools[PoolIndex].MaxSpawns == 255;
}

function int GetVehiclePoolCount()
{
    return VehiclePools.Length;
}

function int GetSpawnPointCount()
{
    return SpawnPoints.Length;
}

static function string GetSpawnErrorString(int SpawnError)
{
    //TODO: return correct spawn error strings
    switch (SpawnError)
    {
        case default.SpawnError_None:
        case default.SpawnError_Fatal:
        case default.SpawnError_MaxVehicles:
        case default.SpawnError_Cooldown:
        case default.SpawnError_SpawnLimit:
        case default.SpawnError_ActiveLimit:
        case default.SpawnError_PoolInactive:
        case default.SpawnError_SpawnInactive:
        case default.SpawnError_Blocked:
        case default.SpawnError_Failed:
        case default.SpawnError_BadTeamPool:
        case default.SpawnError_BadTeamSpawnPoint:
        case default.SpawnError_TryToDriveFailed:
            return "ERROR";
    }
}

static function array<int> CreateScrambledArrayIndices(int Length)
{
    local int i;
    local array<int> Indices;

    Indices.Length = Length;

    for (i = 0; i < Length; ++i)
    {
        Indices[i] = i;
    }

    FisherYatesShuffle(Indices);

    return Indices;
}

static function FisherYatesShuffle(out array<int> _Array)
{
    local int i, j;

    for (i = _Array.Length - 1; i >= 0; --i)
    {
        j = Rand(i);

        Swap(_Array[i], _Array[j]);
    }
}

static function Swap(out int A, out int B)
{
    local int temp;

    temp = A;
    A = B;
    B = temp;
}

defaultproperties
{
    bDirectional=false
    DrawScale=3.000000
    SpawnError_None=0
    SpawnError_Fatal=1
    SpawnError_MaxVehicles=2
    SpawnError_Cooldown=3
    SpawnError_SpawnLimit=4
    SpawnError_ActiveLimit=5
    SpawnError_PoolInactive=6
    SpawnError_SpawnInactive=7
    SpawnError_Blocked=8
    SpawnError_Failed=9
    SpawnError_BadTeamPool=10
    SpawnError_BadTeamSpawnPoint=11
    SpawnError_TryToDriveFailed=12
    SpawnError_BadSpawnType=13
    MaxTeamVehicles(0)=32
    MaxTeamVehicles(1)=32
    MaxDestroyedVehicles=8
    VehicleDestroyedMessageClass=class'DHVehicleDestroyedMessage'
    bDebug=true
    SpawnPointType_Infantry=0
    SpawnPointType_Vehicles=1
}

