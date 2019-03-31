//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_Kar98ScopedFire extends DH_Kar98Fire;

defaultproperties
{
    ProjectileClass=class'DH_Weapons.DH_Kar98ScopedBullet'
    AmmoClass=class'DH_Weapons.DH_Kar98ScopedAmmo'
    Spread=30.0
    PctRestDeployRecoil=0.25
    FireIronAnim="Scope_Shoot"
    ShakeRotMag=(X=50.0,Y=50.0,Z=400.0)
    ShakeRotTime=5.0
    AimError=500.0
}
