//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_JagdpantherCannonPawn extends DHAssaultGunCannonPawn;

defaultproperties
{
    OverlayCenterSize=0.555
    PeriscopePositionIndex=1
    CannonScopeOverlay=texture'DH_Artillery_Tex.ATGun_Hud.ZF_II_3x8_Pak'
    bLockCameraDuringTransition=true
    WeaponFOV=14.4
    AmmoShellTexture=texture'DH_InterfaceArt_tex.Tank_Hud.KingTigerShell'
    AmmoShellReloadTexture=texture'DH_InterfaceArt_tex.Tank_Hud.KingTigerShell_reload'
    DriverPositions(0)=(ViewLocation=(X=60.0,Y=-21.0,Z=10.0),ViewFOV=14.4,PositionMesh=SkeletalMesh'DH_Jagdpanther_anm.Jagdpanther_turret_int',ViewPitchUpLimit=2548,ViewPitchDownLimit=64079,ViewPositiveYawLimit=3000,ViewNegativeYawLimit=-3000,bDrawOverlays=true)
    DriverPositions(1)=(ViewFOV=45.0,PositionMesh=SkeletalMesh'DH_Jagdpanther_anm.Jagdpanther_turret_int',TransitionUpAnim="com_open",DriverTransitionAnim="VStug3_com_close",ViewPitchUpLimit=0,ViewPitchDownLimit=65536,ViewPositiveYawLimit=18000,ViewNegativeYawLimit=-18000,bDrawOverlays=true)
    DriverPositions(2)=(ViewFOV=90.0,PositionMesh=SkeletalMesh'DH_Jagdpanther_anm.Jagdpanther_turret_int',TransitionDownAnim="com_close",DriverTransitionAnim="VStug3_com_open",ViewPitchUpLimit=6000,ViewPitchDownLimit=65000,ViewPositiveYawLimit=100000,ViewNegativeYawLimit=-100000,bExposed=true)
    DriverPositions(3)=(ViewFOV=12.0,PositionMesh=SkeletalMesh'DH_Jagdpanther_anm.Jagdpanther_turret_int',DriverTransitionAnim="stand_idleiron_binoc",ViewPitchUpLimit=6000,ViewPitchDownLimit=65000,ViewPositiveYawLimit=100000,ViewNegativeYawLimit=-100000,bDrawOverlays=true,bExposed=true)
    FireImpulse=(X=-110000.0)
    GunClass=class'DH_Vehicles.DH_JagdpantherCannon'
    bHasAltFire=false
    CameraBone="Gun"
    DrivePos=(X=-3.0,Y=-2.0,Z=-6.0)
    DriveAnim="VStug3_com_idle_close"
    EntryRadius=130.0
    PitchUpLimit=6000
    PitchDownLimit=64000
    SoundVolume=130
}
