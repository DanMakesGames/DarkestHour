//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2018
//==============================================================================

class DHATGun extends DHVehicle
    abstract;

enum ERotateError
{
    ERROR_None,
    ERROR_EnemyGun,
    ERROR_CannotBeRotated,
    ERROR_IsBeingRotated,
    ERROR_Occupied,
    ERROR_NeedMorePlayers,
    ERROR_Fatal,
    ERROR_Cooldown,
    ERROR_TooFarAway
};

var DHPawn            RotateControllerPawn;
var DHRotatingActor   RotatingActor;
var Actor             OldBase;

var ROSoundAttachment RotateSoundAttachment;
var sound             RotateSound;
var float             RotateSoundVolume;

var bool              bIsBeingRotated;
var bool              bCanBeRotated;
var int               NextRotationTime;
var int               PlayersNeededToRotate;
var int               RotateCooldown;
var float             RotateControlRadiusInMeters;
var float             RotationsPerSecond;
var String            SentinelString;
var Rotator           OldRotator;


replication
{
    reliable if (Role == ROLE_Authority)
        bIsBeingRotated;

    reliable if (Role == ROLE_Authority && !IsInState('Rotating'))
        NextRotationTime;

    reliable if (bNetDirty && Role == ROLE_Authority)
        SentinelString;
}

// Disabled as nothing in Tick is relevant to an AT gun (to be on the safe side, MinBrakeFriction is set very high in default properties, so gun won't slide down a hill)
simulated function Tick(float DeltaTime)
{
    Disable('Tick');
}

// Modified so we always use this actor & rely on its modified TryToDrive() function to control entry to the gun
function Vehicle FindEntryVehicle(Pawn P)
{
    return self;
}

// Modified to allow human to kick bot off a gun (also removes stuff not relevant to an AT gun)
function bool TryToDrive(Pawn P)
{
    // Deny entry if gun is destroyed, or if player is on fire or reloading a weapon (plus several very obscure other reasons)
    if (Health <= 0 || P == none || (DHPawn(P) != none && DHPawn(P).bOnFire) || (P.Weapon != none && P.Weapon.IsInState('Reloading')) ||
        P.Controller == none || !P.Controller.bIsPlayer || P.DrivenVehicle != none || P.IsA('Vehicle') || bNonHumanControl || !Level.Game.CanEnterVehicle(self, P) ||
        WeaponPawns.Length == 0 || WeaponPawns[0] == none)
    {
        return false;
    }

    // Deny entry if the gun is being rotated.
    if (bIsBeingRotated)
    {
        DisplayVehicleMessage(14, P);
        return false;
    }

    // Deny entry to enemy gun
    if ((bTeamLocked && P.GetTeamNum() != VehicleTeam) ||
        (!bTeamLocked && WeaponPawns[0].Driver != none && P.GetTeamNum() != WeaponPawns[0].Driver.GetTeamNum())) // if gun not team locked, check enemy player isn't already manning it
    {
        DisplayVehicleMessage(1, P); // can't use enemy gun

        return false;
    }

    // The gun is already manned
    if (WeaponPawns[0].Driver != none)
    {
        // If a human player wants to enter a gun manned by a bot, kick the bot off the gun
        if (!WeaponPawns[0].IsHumanControlled() && P.IsHumanControlled())
        {
            WeaponPawns[0].KDriverLeave(true);
        }
        // Otherwise deny entry to gun that's already manned
        else
        {
            DisplayVehicleMessage(2, P); // gun is already manned

            return false;
        }
    }

    // Passed all checks, so allow player to man the gun
    KDriverEnter(P);

    return true;
}

// Overridden to bypass attaching as a driver and go straight to the gun
function KDriverEnter(Pawn P)
{
    if (WeaponPawns.Length > 0 && WeaponPawns[0] != none)
    {
        WeaponPawns[0].KDriverEnter(P);
    }
}

// Overridden to bypass attaching as a driver and go straight to the gun
simulated function ClientKDriverEnter(PlayerController PC)
{
    if (WeaponPawns.Length > 0 && WeaponPawns[0] != none)
    {
        WeaponPawns[0].ClientKDriverEnter(PC);
    }
}

// Modified to use a different AT cannon message class with some messages that are more appropriate to a gun
simulated function DisplayVehicleMessage(int MessageNumber, optional Pawn P, optional bool bPassController)
{
    if (P == none)
    {
        P = self;
    }

    if (bPassController) // option to pass pawn's controller as the OptionalObject, so it can be used in building the message
    {
        P.ReceiveLocalizedMessage(class'DHATCannonMessage', MessageNumber,,, Controller);
    }
    else
    {
        P.ReceiveLocalizedMessage(class'DHATCannonMessage', MessageNumber);
    }
}

// Modified to use APCDamageModifier, & to remove code preventing players damaging own team's gun that hasn't been entered (only designed to protect vehicles in spawn)
// Also removes other stuff not relevant to a static AT gun (engine & tread stuff & stopping 'vehicle' giving itself impact damage)
function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
    local float DamageModifier;
    local int   i;

    // Suicide/self-destruction
    if (DamageType == class'Suicided' || DamageType == class'ROSuicided')
    {
        super(Vehicle).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, class'ROSuicided');

        return;
    }

    // Apply damage modifier from the DamageType, plus a little damage randomisation
    if (class<ROWeaponDamageType>(DamageType) != none)
    {
        DamageModifier = class<ROWeaponDamageType>(DamageType).default.APCDamageModifier * RandRange(0.75, 1.08);
    }

    Damage *= DamageModifier;

    // Exit if no damage
    if (Damage < 1)
    {
        return;
    }

    // Check RO VehHitpoints, but only for any ammo store (AT gun has no engine)
    for (i = 0; i < VehHitpoints.Length; ++i)
    {
        if (VehHitpoints[i].HitPointType == HP_AmmoStore && IsPointShot(HitLocation, Momentum, 1.0, i))
        {
            if (bDebuggingText)
            {
                Level.Game.Broadcast(self, "Hit AT gun ammo store");
            }

            Damage *= VehHitpoints[i].DamageMultiplier;
            break;
        }
    }

    // Call the Super from Vehicle (skip over others)
    super(Vehicle).TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// Rotation
simulated function ERotateError GetRotationError(DHPawn Pawn, optional out int TeammatesInRadiusCount)
{
    local DHPlayer PC;
    local DHGameReplicationInfo GRI;

    if (Pawn == none)
    {
        return ERROR_Fatal;
    }

    if (VSize(Pawn.Location - Location) > class'DHUnits'.static.MetersToUnreal(RotateControlRadiusInMeters))
    {
        return ERROR_TooFarAway;
    }

    if (Pawn.GetTeamNum() != VehicleTeam)
    {
        return ERROR_EnemyGun;
    }

    if (!bCanBeRotated)
    {
        return ERROR_CannotBeRotated;
    }

    if (bIsBeingRotated)
    {
        return ERROR_IsBeingRotated;
    }

    if (NumPassengers() > 0)
    {
        return ERROR_Occupied;
    }

    PC = DHPlayer(Pawn.Controller);

    if (PC != none)
    {
        GRI = DHGameReplicationInfo(PC.GameReplicationInfo);

        if (GRI == none)
        {
            return ERROR_Fatal;
        }

        if (GRI.ElapsedTime < NextRotationTime)
        {
            return ERROR_Cooldown;
        }
    }
    else
    {
        return ERROR_Fatal;
    }

    /*
    if (PlayersNeededToRotate > 1)
    {
        TeammatesInRadiusCount = GetTeammatesInRadiusCount(Pawn);

        if (TeammatesInRadiusCount < PlayersNeededToRotate)
        {
            return ERROR_NeedMorePlayers;
        }
    }
    */
    return ERROR_None;
}

simulated function int GetTeammatesInRadiusCount(DHPawn Pawn)
{
    local Pawn OtherPawn;
    local DHPlayerReplicationInfo OtherPRI;
    local int Count;

    foreach RadiusActors(class'Pawn', OtherPawn, class'DHUnits'.static.MetersToUnreal(RotateControlRadiusInMeters))
    {
        if (OtherPawn != none &&
            OtherPawn.GetTeamNum() == Pawn.GetTeamNum() &&
            !OtherPawn.bDeleteMe &&
            OtherPawn.Health > 0 &&
            (!OtherPawn.IsA('ROVehicle') || !OtherPawn.IsA('ROVehicleWeaponPawn')))
        {
            OtherPRI = DHPlayerReplicationInfo(OtherPawn.PlayerReplicationInfo);

            if (OtherPRI != none)
            {
                ++Count;
            }
        }
    }

    return Count;
}

function ServerEnterRotation(DHPawn Instigator)
{
    local ERotateError RotateError;

    RotateError = GetRotationError(Instigator);

    if (RotateError != ERROR_None)
    {
        // TODO: Send a message to the player
        Instigator.ClientExitATRotation();
        return;
    }

    RotateControllerPawn = Instigator;
    GotoState('Rotating');
}

function ServerExitRotation()
{

    if (RotatingActor != none && !RotatingActor.bPendingDelete)
    {
        RotatingActor.Destroy();
    }
}

function ServerRotate(byte InputRotationFactor)
{
    local int F;

    if (InputRotationFactor > 127)
    {
        F = InputRotationFactor - 256;
    }
    else
    {
        F = InputRotationFactor;
    }

    HandleRotate(F);
}

function HandleRotate(int RotationFactor);
function OnRotatingActorDestroyed(int Time);



state Rotating
{
    function BeginState()
    {


        bIsBeingRotated = true;



        RotatingActor = Spawn(class'DHRotatingActor',,, Location, Rotation);
        RotatingActor.OnDestroyed = OnRotatingActorDestroyed;
        RotatingActor.ControlRadiusInMeters = RotateControlRadiusInMeters;
        RotatingActor.ControllerPawn = RotateControllerPawn;

        if (RotateSound != none)
        {
            RotateSoundAttachment = Spawn(class'ROSoundAttachment');
            RotateSoundAttachment.AmbientSound = RotateSound;
            RotateSoundAttachment.SetBase(self);
        }
        log("  ASDASD ASD ASD BINGO");
        bCollideWorld = False;
        SetPhysics(PHYS_None);
        SetBase(RotatingActor);
    }

    function OnRotatingActorDestroyed(int Time)
    {
        NextRotationTime = Time + RotateCooldown;
        GotoState('');
    }

    function HandleRotate(int RotationFactor)
    {
        Log("Handle Rotation");
        RotatingActor.SetRotationFactor(RotationFactor);

        if (RotateSoundAttachment != none)
        {
            if (RotationFactor == 0)
            {
                RotateSoundAttachment.SoundVolume = 0.0;
            }
            else
            {
                RotateSoundAttachment.SoundVolume = RotateSoundVolume;
            }
        }
    }

    function EndState()
    {
        if (RotatingActor != none && !RotatingActor.bPendingDelete)
        {
            RotatingActor.Destroy();
        }

        if (RotateSoundAttachment != none)
        {
            RotateSoundAttachment.Destroy();
        }

        SetBase(none);


        // my addition hoping to force the server in line with the client.
        SetRotation(RotatingActor.DesiredRotation);



        SentinelString = String(Rotation);


        bCollideWorld = False;
        SetPhysics(PHYS_Karma);

        bIsBeingRotated = false;

        if (RotateControllerPawn != none)
        {
            RotateControllerPawn.ClientExitATRotation();
        }
    }
}


// Used to force the final server rotation onto the clients. Gets around replication ownership issue.
simulated event PostNetReceive()
{
    local Rotator uncomRotation;
    local int firstComma,secondComma;
    local String CutSentinel;
    super.PostNetReceive();

    // Rotation is sent as string, process.
    firstComma = InStr(SentinelString,",");
    uncomRotation.Pitch = Int(Left(SentinelString, firstComma));
    CutSentinel = Mid(SentinelString,firstComma + 1);
    secondComma = InStr(CutSentinel, ",");
    uncomRotation.Yaw = Int(Left(CutSentinel, secondComma));
    uncomRotation.Roll = Int(Mid(CutSentinel, secondComma + 1));


    if(OldRotator != unComRotation)
    {

        OldRotator = uncomRotation;

        SetPhysics(PHYS_None);
        SetRotation(uncomRotation);
        SetPhysics(PHYS_Karma);
    }
}

// Overriden to suppress the touch message when the gun is being rotated
// TODO: This is probably not the best way to do this
simulated event NotifySelected(Pawn User)
{
    if (!bIsBeingRotated)
    {
        super.NotifySelected(User);

    }
}

// Functions emptied out as AT gun bases cannot be occupied & have no engine or treads:
function Fire(optional float F);
function ServerStartEngine();
simulated function SetEngine();
simulated function StopEmitters();
simulated function StartEmitters();
simulated function UpdateMovementSound(float MotionSoundVolume);
function DamageEngine(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType);
simulated function SetupTreads();
simulated function DestroyTreads();
function CheckTreadDamage(vector HitLocation, vector Momentum);
function DamageTrack(bool bLeftTrack);
simulated function SetDamagedTracks();
simulated event DrivingStatusChanged();
simulated function NextWeapon();
simulated function PrevWeapon();
function ServerChangeViewPoint(bool bForward);
simulated function NextViewPoint();
simulated function SwitchWeapon(byte F);
function ServerChangeDriverPosition(byte F);
simulated function bool CanSwitchToVehiclePosition(byte F) { return false; }
function bool KDriverLeave(bool bForceLeave) { return false; }
function DriverDied();
function DriverLeft();
simulated function bool CanExit() { return false; }
function bool PlaceExitingDriver() { return false; }
simulated function Destroyed_HandleDriver();
simulated function SetPlayerPosition();
simulated function SpecialCalcFirstPersonView(PlayerController PC, out Actor ViewActor, out vector CameraLocation, out rotator CameraRotation);
simulated function DrawHUD(Canvas C);
simulated function DrawPeriscopeOverlay(Canvas C);
simulated function POVChanged(PlayerController PC, bool bBehindViewChanged);
simulated function int LimitYaw(int yaw) { return yaw; }
function int LimitPawnPitch(int pitch) { return pitch; }
simulated function float GetViewFOV(int PositionIndex) { return 0.0; }
simulated function SetViewFOV(int PositionIndex, optional PlayerController PC);
function bool ResupplyAmmo() { return false; }

defaultproperties
{
    // Key properties
    bNeverReset=true // AT gun never re-spawns if left unattended with no friendlies nearby or is left disabled
    bNetNotify=true // AT gun doesn't use PostNetReceive() as engine on/off, damaged tracks & hull fires are all irrelevant to it
    bHasTreads=false
    bMustBeTankCommander=false
    bMultiPosition=false
    bSpecialHUD=false

    // Damage
    HealthMax=101.0
    Health=101
    EngineHealth=0
    VehHitpoints(0)=(PointRadius=0.0,PointBone="",DamageMultiplier=0.0) // remove inherited values for vehicle engine
    DamagedEffectClass=none
    DestructionEffectClass=class'AHZ_ROVehicles.ATCannonDestroyedEmitter'
    DisintegrationEffectClass=class'AHZ_ROVehicles.ATCannonDestroyedEmitter'
    DestructionLinearMomentum=(Min=0.0,Max=0.0)
    DestructionAngularMomentum=(Min=0.0,Max=0.0)
    bCanCrash=false

    // Miscellaneous
    TouchMessage="Use the "
    VehicleMass=5.0 // TODO: rationalise the mass & centre of mass settings of guns, but experiment with effect on ground contact & vehicle collisions
    MaxDesireability=1.9
    CollisionRadius=75.0
    CollisionHeight=100.0
    BeginningIdleAnim=""
    MinBrakeFriction=40.0
    VehicleHudOccupantsX(0)=0.0 // neutralise driver & hull gunner positions
    VehicleHudOccupantsX(2)=0.0
    PointValue=200

    // Exit positions
    ExitPositions(0)=(X=0.0,Y=0.0,Z=100.0)  // last resort (because we start at index 1 for a cannon pawn)
    ExitPositions(1)=(X=-100.0,Y=0.0,Z=0.0) // index 1 is gunner's 1st choice exit position
    ExitPositions(2)=(X=-150.0,Y=0.0,Z=0.0) // all the rest are generic fallbacks to try different positions to try & get the player off the gun
    ExitPositions(3)=(X=-100.0,Y=25.0,Z=0.0)
    ExitPositions(4)=(X=-100.0,Y=-25.0,Z=0.0)
    ExitPositions(5)=(X=-100.0,Y=50.0,Z=0.0)
    ExitPositions(6)=(X=-100.0,Y=-50.0,Z=0.0)
    ExitPositions(7)=(X=-50.0,Y=50.0,Z=0.0)
    ExitPositions(8)=(X=-50.0,Y=-50.0,Z=0.0)
    ExitPositions(9)=(X=-50.0,Y=50.0,Z=50.0)
    ExitPositions(10)=(X=-50.0,Y=-50.0,Z=50.0)
    ExitPositions(11)=(X=-75.0,Y=75.0,Z=50.0)
    ExitPositions(12)=(X=-75.0,Y=-75.0,Z=50.0)
    ExitPositions(13)=(X=-100.0,Y=0.0,Z=75.0)
    ExitPositions(14)=(X=-100.0,Y=75.0,Z=75.0)
    ExitPositions(15)=(X=-100.0,Y=-75.0,Z=75.0)

    // Rotation
    PlayersNeededToRotate=1
    RotationsPerSecond=0.125
    bFixedRotationDir=false
    RotateCooldown=5
    RotateControlRadiusInMeters=5
    RotateSound=Sound'Vehicle_Weapons.Turret.manual_turret_elevate'
    RotateSoundVolume=20.0
    //SentinelRotator=(Pitch=0,Yaw=0,Roll=0)
    OldRotator=(Pitch=0,Yaw=0,Roll=0)



    // Karma properties
    Begin Object Class=KarmaParamsRBFull Name=KParams0
        KInertiaTensor(0)=1.0
        KInertiaTensor(3)=3.0
        KInertiaTensor(5)=3.0
        KCOMOffset=(Z=-0.5)
        KLinearDamping=0.05
        KAngularDamping=0.05
        KStartEnabled=true
        bKNonSphericalInertia=true
        KMaxAngularSpeed=0.0 // default is 1.0 (AT gun can't move, so KParams is probably an unnecessary override)
        bHighDetailOnly=false
        bClientOnly=false
        bKDoubleTickRate=true
        bDestroyOnWorldPenetrate=true
        bDoSafetime=true
        KFriction=0.5
        KImpactThreshold=700.0
    End Object
    KParams=KarmaParamsRBFull'DH_Engine.DHATGun.KParams0'
}
