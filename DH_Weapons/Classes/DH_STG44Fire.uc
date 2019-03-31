//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_STG44Fire extends DHAutomaticFire;

defaultproperties
{
    ProjectileClass=class'DH_Weapons.DH_STG44Bullet'
    AmmoClass=class'ROAmmo.STG44Ammo'
    FAProjSpawnOffset=(X=-28.0)
    FireRate=0.14
    Spread=140.0
    RecoilRate=0.07
    MaxVerticalRecoilAngle=260
    MaxHorizontalRecoilAngle=40
    FireSounds(0)=SoundGroup'DH_WeaponSounds.stg44.stg44_fire01'
    FireSounds(1)=SoundGroup'DH_WeaponSounds.stg44.stg44_fire02'
    FireSounds(2)=SoundGroup'DH_WeaponSounds.stg44.stg44_fire03'
    ShellEjectClass=class'ROAmmo.ShellEject1st556mm'
    ShellIronSightOffset=(X=15.0,Y=0.0,Z=-2.5)
    ShellRotOffsetIron=(Pitch=2000)
    bReverseShellSpawnDirection=true
    ShakeRotMag=(X=50.0,Y=50.0,Z=175.0)
    ShakeRotTime=0.75
}
