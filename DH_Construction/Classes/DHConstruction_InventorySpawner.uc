//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHConstruction_InventorySpawner extends DHConstruction
    abstract;

var class<DHInventorySpawner>   SpawnerClass;
var DHInventorySpawner          Spawner;

static function class<DHInventorySpawner> GetSpawnerClass(DHConstruction.Context Context)
{
    return default.SpawnerClass;
}

static function DHConstruction.ConstructionError GetPlayerError(DHConstruction.Context Context)
{
    local DHConstruction.ConstructionError Error;

    if (GetSpawnerClass(Context) == none)
    {
        Error.Type = ERROR_Fatal;
        return Error;
    }

    return super.GetPlayerError(Context);
}

simulated function OnConstructed()
{
    if (Role == ROLE_Authority)
    {
        if (Spawner != none)
        {
            Spawner.Destroy();
        }

        Spawner = Spawn(GetSpawnerClass(GetContext()), Level,, Location, Rotation);
        Spawner.SetTeamIndex(GetTeamIndex());
        Spawner.OnExhausted = self.OnExhausted;
        Spawner.bShouldDestroyOnExhaustion = true;
    }
}

static function UpdateProxy(DHConstructionProxy CP)
{
    local int i;
    local class<DHInventorySpawner> SpawnerClass;

    super.UpdateProxy(CP);

    SpawnerClass = GetSpawnerClass(CP.GetContext());

    CP.SetDrawType(DT_Mesh);
    CP.LinkMesh(GetSpawnerClass(CP.GetContext()).default.Mesh);

    for (i = 0; i < SpawnerClass.default.Skins.Length; ++i)
    {
        CP.Skins[i] = CP.CreateProxyMaterial(SpawnerClass.default.Skins[i]);
    }
}

static function string GetMenuName(DHConstruction.Context Context)
{
    local class<DHInventorySpawner> SpawnerClass;

    SpawnerClass = GetSpawnerClass(Context);
    
    if (SpawnerClass != none)
    {
        return SpawnerClass.static.GetMenuName();
    }
    
    return "";
}

static function GetCollisionSize(DHConstruction.Context Context, out float NewRadius, out float NewHeight)
{
    local class<DHInventorySpawner> SpawnerClass;

    SpawnerClass = GetSpawnerClass(Context);

    if (SpawnerClass != none)
    {
        NewRadius = SpawnerClass.default.CollisionRadius;
        NewHeight = SpawnerClass.default.CollisionHeight;
    }
}

function Reset()
{
    super.Reset();

    if (Spawner != none)
    {
        Spawner.Destroy();
    }
}

simulated function OnExhausted(DHInventorySpawner Spawner)
{
    if (Owner != none)
    {
        Destroy();
    }
}

defaultproperties
{
    GroupClass=class'DHConstructionGroup_Ammunition'
    SpawnerClass=class'DH_Weapons.DH_StielGranateSpawner'
    bDummyOnConstruction=true
    ProxyTraceDepthMeters=2.0
    bCanPlaceIndoors=true
    ConstructionVerb="drop"
    DuplicateFriendlyDistanceInMeters=1.0

    CompletionPointValue=100
}

