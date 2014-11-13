//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_17PounderGunCannon extends DH_ATGunCannon;

defaultproperties
{
     SecondarySpread=0.001560
     ReloadSoundOne=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_01'
     ReloadSoundTwo=Sound'DH_Vehicle_Reloads.Reloads.reload_02s_03'
     ReloadSoundThree=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_04'
     CannonFireSound(0)=SoundGroup'DH_AlliedVehicleSounds.17pounder.DH17pounder'
     CannonFireSound(1)=SoundGroup'DH_AlliedVehicleSounds.17pounder.DH17pounder'
     CannonFireSound(2)=SoundGroup'DH_AlliedVehicleSounds.17pounder.DH17pounder'
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
     VehHitpoints(0)=(PointRadius=9.000000,PointScale=1.000000,PointBone="com_player",PointOffset=(X=-12.000000,Y=-12.000000,Z=-35.000000))
     VehHitpoints(1)=(PointRadius=15.000000,PointScale=1.000000,PointBone="com_player",PointOffset=(X=-12.000000,Y=-12.000000,Z=-55.000000))
     YawBone="Turret"
     YawStartConstraint=-6000.000000
     YawEndConstraint=6000.000000
     PitchBone="gun01"
     PitchUpLimit=15000
     PitchDownLimit=45000
     WeaponFireAttachmentBone="Barrel"
     GunnerAttachmentBone="com_player"
     WeaponFireOffset=20.000000
     RotationsPerSecond=0.020000
     FireInterval=4.000000
     EffectEmitterClass=Class'ROEffects.TankCannonFireEffect'
     FireSoundVolume=512.000000
     RotateSound=Sound'Vehicle_Weapons.Turret.manual_gun_traverse'
     FireForce="Explosion05"
     ProjectileClass=Class'DH_Guns.DH_17PounderCannonShell'
     ShakeRotMag=(Z=110.000000)
     ShakeRotRate=(Z=1100.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Z=5.000000)
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=2.000000
     AIInfo(0)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.500000)
     AIInfo(1)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.015000)
     CustomPitchUpLimit=3004
     CustomPitchDownLimit=64444
     MaxPositiveYaw=5460
     MaxNegativeYaw=-5460
     bLimitYaw=true
     BeginningIdleAnim="com_idle_close"
     InitialPrimaryAmmo=60
     InitialSecondaryAmmo=30
     PrimaryProjectileClass=Class'DH_Guns.DH_17PounderCannonShell'
     SecondaryProjectileClass=Class'DH_Guns.DH_17PounderCannonShellHE'
     Mesh=SkeletalMesh'DH_17PounderGun_anm.17Pounder_turret'
     Skins(0)=Texture'DH_Artillery_Tex.17pounder.17Pounder_ext'
     Skins(1)=Texture'Weapons1st_tex.Bullets.Bullet_Shell_Rifle_MN'
     SoundVolume=130
     SoundRadius=200.000000
}
