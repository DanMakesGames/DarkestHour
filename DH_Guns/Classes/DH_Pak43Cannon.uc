//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DH_Pak43Cannon extends DHATGunCannon;

defaultproperties
{
    SecondarySpread=0.00135
    ReloadSoundOne=sound'DH_Vehicle_Reloads.Reloads.reload_02s_01'
    ReloadSoundTwo=sound'DH_Vehicle_Reloads.Reloads.reload_01s_02'
    ReloadSoundThree=sound'DH_Vehicle_Reloads.Reloads.reload_02s_03'
    ReloadSoundFour=sound'DH_Vehicle_Reloads.Reloads.reload_02s_04'
    CannonFireSound(0)=SoundGroup'DH_GerVehicleSounds.88mm.DH88mm_01'
    CannonFireSound(1)=SoundGroup'DH_GerVehicleSounds.88mm.DH88mm_02'
    CannonFireSound(2)=SoundGroup'DH_GerVehicleSounds.88mm.DH88mm_03'
    ProjectileDescriptions(0)="APCBC"
    RangeSettings(1)=100
    RangeSettings(2)=200
    RangeSettings(3)=300
    RangeSettings(4)=400
    RangeSettings(5)=500
    RangeSettings(6)=600
    RangeSettings(7)=700
    RangeSettings(8)=800
    RangeSettings(9)=900
    RangeSettings(10)=1000
    RangeSettings(11)=1100
    RangeSettings(12)=1200
    RangeSettings(13)=1300
    RangeSettings(14)=1400
    RangeSettings(15)=1500
    RangeSettings(16)=1600
    RangeSettings(17)=1700
    RangeSettings(18)=1800
    RangeSettings(19)=1900
    RangeSettings(20)=2000
    RangeSettings(21)=2200
    RangeSettings(22)=2400
    RangeSettings(23)=2600
    RangeSettings(24)=2800
    RangeSettings(25)=3000
    YawBone="Turret"
    YawStartConstraint=-6000.0
    YawEndConstraint=6000.0
    PitchBone="Gun"
    PitchUpLimit=15000
    PitchDownLimit=45000
    WeaponFireAttachmentBone="Barrel"
    GunnerAttachmentBone="com_player"
    WeaponFireOffset=-3.0
    RotationsPerSecond=0.017
    FireInterval=6.0
    FireSoundVolume=512.0
    FireForce="Explosion05"
    ProjectileClass=class'DH_Guns.DH_Pak43CannonShell'
    ShakeRotMag=(Z=110.0)
    ShakeRotRate=(Z=1100.0)
    ShakeRotTime=2.0
    ShakeOffsetMag=(Z=5.0)
    ShakeOffsetRate=(Z=100.0)
    ShakeOffsetTime=2.0
    AIInfo(0)=(bLeadTarget=true,WarnTargetPct=0.75,RefireRate=0.5)
    AIInfo(1)=(bLeadTarget=true,WarnTargetPct=0.75,RefireRate=0.015)
    CustomPitchUpLimit=6918
    CustomPitchDownLimit=64626
    MaxPositiveYaw=5097
    MaxNegativeYaw=-5097
    bLimitYaw=true
    BeginningIdleAnim="com_idle_close"
    InitialPrimaryAmmo=50
    InitialSecondaryAmmo=42
    PrimaryProjectileClass=class'DH_Guns.DH_Pak43CannonShell'
    SecondaryProjectileClass=class'DH_Guns.DH_Pak43CannonShellHE'
    Mesh=SkeletalMesh'DH_Pak43_anm.pak43_turret'
    Skins(0)=texture'DH_Artillery_Tex.Pak43.pak43_nocamo_ext'
    SoundVolume=130
    SoundRadius=200.0
}
