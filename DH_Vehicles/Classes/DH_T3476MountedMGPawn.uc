//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_T3476MountedMGPawn extends DHVehicleMGPawn;

defaultproperties
{
    GunClass=class'DH_Vehicles.DH_T3476MountedMG'
    GunsightOverlay=Texture'DH_VehicleOptics_tex.General.MG_sight'
    GunsightSize=0.5
    WeaponFOV=72.0
    CameraBone="MG_pivot"
    FPCamPos=(X=4.0,Y=0.0,Z=2.0)
    PitchUpLimit=3000
    PitchDownLimit=63500
    VehicleMGReloadTexture=Texture'DH_InterfaceArt_tex.Tank_Hud.DT_ammo_reload'
}
