//==============================================================================
// DH_Sdkfz2341ArmoredCar_Snow
//
// Darkest Hour Source - (c) Darkest Hour Team 2010
// Red Orchestra Source - (c) Tripwire Interactive 2006
//
// Sdkfz 234/1 German Armored Reconnaisance Car
//==============================================================================
class DH_Sdkfz2341ArmoredCar_Snow extends DH_Sdkfz2341ArmoredCar;

#exec OBJ LOAD FILE=..\Textures\DH_VehiclesGE_tex5.utx

static function StaticPrecache(LevelInfo L)
{
    Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_body_snow');
    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_wheels_snow');
    L.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_extras_snow');

}

simulated function UpdatePrecacheMaterials()
{

    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_body_snow');
    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_wheels_snow');
    Level.AddPrecacheMaterial(Material'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_extras_snow');

    Super.UpdatePrecacheMaterials();
}

defaultproperties
{
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_Sdkfz2341CannonPawn_Snow')
     DestroyedVehicleMesh=StaticMesh'DH_German_vehicles_stc3.234.234_destsnow'
     Skins(0)=Texture'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_body_snow'
     Skins(1)=Texture'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_wheels_snow'
     Skins(2)=Texture'DH_VehiclesGE_tex5.ext_vehicles.sdkfz2341_extras_snow'
}
