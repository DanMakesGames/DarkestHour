//==============================================================================
// DH_ShermanTank_Snow
//
// Darkest Hour Source - (c) Darkest Hour Team 2010
// Red Orchestra Source - (c) Tripwire Interactive 2006
//
// American M4A1 (Sherman) 75mm tank - winter version
//==============================================================================
class DH_ShermanTank_Snow extends DH_ShermanTank;

#exec OBJ LOAD FILE=..\textures\DH_VehiclesUS_tex2.utx

static function StaticPrecache(LevelInfo L)
{
    super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.Sherman_body_int');
    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.Sherman_body_int2');
    L.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex2.ext_vehicles.Sherman_body_snow');
    L.AddPrecacheMaterial(Material'DH_VehiclesUS_tex.treads.Sherman_treads');
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.Sherman_body_int');
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex.int_vehicles.Sherman_body_int2');
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_Tex2.ext_vehicles.Sherman_body_snow');
    Level.AddPrecacheMaterial(Material'DH_VehiclesUS_tex.treads.Sherman_treads');

    super.UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_ShermanCannonPawn_Snow')
     Skins(0)=Texture'DH_VehiclesUS_tex2.ext_vehicles.Sherman_body_snow'
}
