//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_45mmM1942GunCannonShell extends DH_45mmM1937GunCannonShell;

defaultproperties
{
    Speed=52506.0 // 870 m/s
    MaxSpeed=52506.0
    ImpactDamage=320

    DHPenetrationTable(0)=7.1  // 100m // TODO: confirm penetration
    DHPenetrationTable(1)=6.3  // 250m
    DHPenetrationTable(2)=5.4  // 500m
    DHPenetrationTable(3)=4.6
    DHPenetrationTable(4)=4.0  // 1000m
    DHPenetrationTable(5)=3.5
    DHPenetrationTable(6)=3.2  // 1500m
    DHPenetrationTable(7)=3.0
    DHPenetrationTable(8)=2.8  // 2000m
    DHPenetrationTable(9)=2.4
    DHPenetrationTable(10)=2.1 // 3000m

    MechanicalRanges(1)=(Range=500,RangeValue=-45.0) // this cannon doesn't actually have mechanical aiming, but this is a fudge to adjust for sight markings that are 'out'
    MechanicalRanges(2)=(Range=1000,RangeValue=-102.0)
    MechanicalRanges(3)=(Range=1500,RangeValue=-160.0) // can only set up to here
    MechanicalRanges(4)=(Range=2000,RangeValue=-218.0)
    MechanicalRanges(5)=(Range=2500,RangeValue=-276.0)
}
