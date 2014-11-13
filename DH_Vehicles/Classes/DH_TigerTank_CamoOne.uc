//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_TigerTank_CamoOne extends DH_TigerTank_Late;

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex.ext_vehicles.Tiger_body_camo1');

}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex.ext_vehicles.Tiger_body_camo1');

    Super.UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_TigerCannonPawn_CamoOne')
     DestroyedVehicleMesh=StaticMesh'DH_German_vehicles_stc.Tiger1.Tiger1_Destroyed'
     Skins(0)=Texture'DH_VehiclesGE_tex.ext_vehicles.Tiger_body_camo1'
}
