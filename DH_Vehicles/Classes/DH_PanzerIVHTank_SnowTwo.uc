//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_PanzerIVHTank_SnowTwo extends DH_PanzerIVHTank;


static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex3.ext_vehicles.Panzer4J_body_snow1');
    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex3.ext_vehicles.PanzerIV_armor_snow2');
    //L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer4F2_treadsnow');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex3.ext_vehicles.Panzer4J_body_snow1');
    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex3.ext_vehicles.PanzerIV_armor_snow2');
    //Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Panzer4F2_treadsnow');

    Super.UpdatePrecacheMaterials();
}

defaultproperties
{
     bHasAddedSideArmor=true
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_PanzerIVHCannonPawn_SnowTwo')
     DestroyedVehicleMesh=StaticMesh'DH_German_vehicles_stc.Panzer4H.Panzer4H_Destroyed2'
     VehicleHudImage=Texture'InterfaceArt2_tex.Tank_Hud.panzer4H_body'
     Skins(0)=Texture'DH_VehiclesGE_tex3.ext_vehicles.Panzer4J_body_snow1'
     Skins(3)=Texture'DH_VehiclesGE_tex3.ext_vehicles.PanzerIV_armor_snow2'
}
