//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_BazookaFire extends DHRocketFire;

defaultproperties
{
    ProjectileClass=class'DH_Weapons.DH_BazookaRocket'
    AmmoClass=class'DH_Weapons.DH_BazookaAmmo'
    Spread=480.0
    ExhaustDamageType=class'DH_Weapons.DH_BazookaExhaustDamType'
    ExhaustDamage=180.0
    ExhaustLength=320.0
    MuzzleBone="warhead1"
}
