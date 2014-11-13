//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_HetzerDestroyer_CamoTwo_Bushes extends DH_HetzerDestroyer;

static function StaticPrecache(LevelInfo L)
{
    Super(ROTreadCraft).StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_body_camo2');
   	L.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
   	L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_int');
   	L.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.Hetzer_driver_glass');
    L.AddPrecacheMaterial(Material'VegetationSMT.WildBushesFall.WildBush_A_FallB');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_body_camo2');
   	Level.AddPrecacheMaterial(Material'axis_vehicles_tex.Treads.Stug3_treads');
   	Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.hetzer_int');
   	Level.AddPrecacheMaterial(Material'DH_Hetzer_tex_V1.Hetzer_driver_glass');
    Level.AddPrecacheMaterial(Material'VegetationSMT.WildBushesFall.WildBush_A_FallB');

	Super(ROTreadCraft).UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_HetzerCannonPawn_CamoTwo')
     PassengerWeapons(1)=(WeaponPawnClass=Class'DH_Vehicles.DH_HetzerMountedMGPawn_CamoTwo')
     Skins(0)=Texture'DH_Hetzer_tex_V1.hetzer_body_camo2'
     Skins(3)=Texture'VegetationSMT.WildBushesFall.WildBush_A_FallB'
}
