//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_ShermanCannon_M4A3105 extends DHVehicleCannon;

defaultproperties
{
    InitialTertiaryAmmo=6
    TertiaryProjectileClass=class'DH_Vehicles.DH_ShermanM4A3105CannonShellSmoke'
    SecondarySpread=0.003
    TertiarySpread=0.0036
    ManualRotationsPerSecond=0.0125
    FrontArmorFactor=9.0
    RightArmorFactor=5.1
    LeftArmorFactor=5.1
    RearArmorFactor=2.5
    RightArmorSlope=5.0
    LeftArmorSlope=5.0
    FrontLeftAngle=316.0
    FrontRightAngle=44.0
    RearRightAngle=136.0
    RearLeftAngle=224.0
    ReloadSoundOne=sound'Vehicle_reloads.Reloads.Pz_IV_F2_Reload_01'
    ReloadSoundTwo=sound'Vehicle_reloads.Reloads.Pz_IV_F2_Reload_02'
    ReloadSoundThree=sound'Vehicle_reloads.Reloads.Pz_IV_F2_Reload_03'
    ReloadSoundFour=sound'Vehicle_reloads.Reloads.Pz_IV_F2_Reload_04'
    CannonFireSound(0)=SoundGroup'Vehicle_Weapons.Tiger.88mm_fire01'
    CannonFireSound(1)=SoundGroup'Vehicle_Weapons.Tiger.88mm_fire02'
    CannonFireSound(2)=SoundGroup'Vehicle_Weapons.Tiger.88mm_fire03'
    ProjectileDescriptions(0)="HEAT"
    ProjectileDescriptions(2)="Smoke"
    AddedPitch=340
    ReloadSound=sound'Vehicle_reloads.Reloads.MG34_ReloadHidden'
    NumAltMags=5
    AltTracerProjectileClass=class'DH_30CalVehicleTracerBullet'
    AltFireTracerFrequency=5
    bUsesTracers=true
    bAltFireTracersOnly=true
    MinCommanderHitHeight=45.0;
    VehHitpoints(0)=(PointRadius=9.0,PointScale=1.0,PointBone="com_player",PointOffset=(Z=6.0))
    VehHitpoints(1)=(PointRadius=12.0,PointScale=1.0,PointBone="com_player",PointOffset=(Z=-5.0))
    hudAltAmmoIcon=texture'InterfaceArt_tex.HUD.mg42_ammo'
    YawBone="Turret"
    PitchBone="Gun"
    PitchUpLimit=15000
    PitchDownLimit=45000
    WeaponFireAttachmentBone="Barrel"
    GunnerAttachmentBone="com_attachment"
    WeaponFireOffset=12.0
    AltFireOffset=(X=-70.0,Y=-17.0,Z=7.5)
    bAmbientAltFireSound=true
    Spread=0.00225
    FireInterval=10.0
    AltFireInterval=0.12
    FireSoundVolume=512.0
    AltFireSoundClass=SoundGroup'DH_AlliedVehicleSounds2.3Cal.V30cal_loop01'
    AltFireSoundScaling=3.0
    AltFireEndSound=SoundGroup'DH_AlliedVehicleSounds2.3Cal.V30cal_end01'
    FireForce="Explosion05"
    ProjectileClass=class'DH_Vehicles.DH_ShermanM4A3105CannonShellHEAT'
    AltFireProjectileClass=class'DH_Vehicles.DH_30CalVehicleBullet'
    ShakeRotMag=(Z=50.0)
    ShakeRotRate=(Z=1000.0)
    ShakeRotTime=4.0
    ShakeOffsetMag=(Z=1.0)
    ShakeOffsetRate=(Z=100.0)
    ShakeOffsetTime=10.0
    AltShakeRotMag=(X=0.01,Y=0.01,Z=0.01)
    AltShakeRotRate=(X=1000.0,Y=1000.0,Z=1000.0)
    AltShakeRotTime=2.0
    AltShakeOffsetMag=(X=0.01,Y=0.01,Z=0.01)
    AltShakeOffsetRate=(X=1000.0,Y=1000.0,Z=1000.0)
    AltShakeOffsetTime=2.0
    AIInfo(0)=(bLeadTarget=true,WarnTargetPct=0.75,RefireRate=0.5)
    AIInfo(1)=(bLeadTarget=true,WarnTargetPct=0.75,RefireRate=0.015)
    CustomPitchUpLimit=6372
    CustomPitchDownLimit=63716
    BeginningIdleAnim="com_idle_close"
    InitialPrimaryAmmo=15
    InitialSecondaryAmmo=45
    InitialAltAmmo=200
    PrimaryProjectileClass=class'DH_Vehicles.DH_ShermanM4A3105CannonShellHEAT'
    SecondaryProjectileClass=class'DH_Vehicles.DH_ShermanM4A3105CannonShellHE'
    Mesh=SkeletalMesh'DH_ShermanM4A3_anm.ShermanM4A3105_turret_ext'
    Skins(0)=texture'DH_VehiclesUS_tex3.ext_vehicles.Sherman_105_ext'
    SoundVolume=200
    SoundRadius=50.0
}
