//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_Pak43Cannon extends DH_ATGunCannon;

defaultproperties
{
     SecondarySpread=0.001350
     ReloadSoundOne=Sound'DH_Vehicle_Reloads.Reloads.reload_02s_01'
     ReloadSoundTwo=Sound'DH_Vehicle_Reloads.Reloads.reload_02s_03'
     ReloadSoundThree=Sound'DH_Vehicle_Reloads.Reloads.reload_02s_04'
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
     YawStartConstraint=-6000.000000
     YawEndConstraint=6000.000000
     PitchBone="Gun"
     PitchUpLimit=15000
     PitchDownLimit=45000
     WeaponFireAttachmentBone="Gun"
     GunnerAttachmentBone="com_player"
     WeaponFireOffset=340.000000
     RotationsPerSecond=0.017000
     FireInterval=6.000000
     EffectEmitterClass=Class'ROEffects.TankCannonFireEffect'
     FireSoundVolume=512.000000
     RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
     FireForce="Explosion05"
     ProjectileClass=Class'DH_Guns.DH_Pak43CannonShell'
     ShakeRotMag=(Z=110.000000)
     ShakeRotRate=(Z=1100.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Z=5.000000)
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=2.000000
     AIInfo(0)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.500000)
     AIInfo(1)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.015000)
     CustomPitchUpLimit=6918
     CustomPitchDownLimit=64626
     MaxPositiveYaw=5097
     MaxNegativeYaw=-5097
     bLimitYaw=true
     BeginningIdleAnim="com_idle_close"
     InitialPrimaryAmmo=50
     InitialSecondaryAmmo=42
     PrimaryProjectileClass=Class'DH_Guns.DH_Pak43CannonShell'
     SecondaryProjectileClass=Class'DH_Guns.DH_Pak43CannonShellHE'
     Mesh=SkeletalMesh'DH_Pak43_anm.pak43_turret'
     Skins(0)=Texture'DH_Artillery_Tex.Pak43.pak43_nocamo_ext'
     SoundVolume=130
     SoundRadius=200.000000
}
