//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_6PounderCannonShellHE extends DH_ROTankCannonShellHE;

defaultproperties
{
     MechanicalRanges(1)=(Range=100,RangeValue=1.000000)
     MechanicalRanges(2)=(Range=200,RangeValue=2.000000)
     MechanicalRanges(3)=(Range=300,RangeValue=3.000000)
     MechanicalRanges(4)=(Range=400,RangeValue=4.000000)
     MechanicalRanges(5)=(Range=500,RangeValue=5.500000)
     MechanicalRanges(6)=(Range=600,RangeValue=7.000000)
     MechanicalRanges(7)=(Range=700,RangeValue=15.000000)
     MechanicalRanges(8)=(Range=800,RangeValue=25.000000)
     MechanicalRanges(9)=(Range=900,RangeValue=45.000000)
     MechanicalRanges(10)=(Range=1000,RangeValue=62.000000)
     MechanicalRanges(11)=(Range=1100,RangeValue=72.000000)
     MechanicalRanges(12)=(Range=1200,RangeValue=80.000000)
     MechanicalRanges(13)=(Range=1300,RangeValue=92.000000)
     MechanicalRanges(14)=(Range=1400,RangeValue=102.000000)
     MechanicalRanges(15)=(Range=1500,RangeValue=112.000000)
     MechanicalRanges(16)=(Range=1600,RangeValue=118.000000)
     MechanicalRanges(17)=(Range=1700,RangeValue=134.000000)
     MechanicalRanges(18)=(Range=1800,RangeValue=172.000000)
     MechanicalRanges(19)=(Range=1900,RangeValue=186.000000)
     MechanicalRanges(20)=(Range=2000,RangeValue=210.000000)
     OpticalRanges(1)=(Range=100)
     OpticalRanges(2)=(Range=200)
     OpticalRanges(3)=(Range=300)
     OpticalRanges(4)=(Range=400)
     OpticalRanges(5)=(Range=500,RangeValue=0.500000)
     OpticalRanges(6)=(Range=600)
     OpticalRanges(7)=(Range=700)
     OpticalRanges(8)=(Range=800)
     OpticalRanges(9)=(Range=900)
     OpticalRanges(10)=(Range=1000)
     OpticalRanges(11)=(Range=1100)
     OpticalRanges(12)=(Range=1200)
     OpticalRanges(13)=(Range=1300)
     OpticalRanges(14)=(Range=1400)
     OpticalRanges(15)=(Range=1500)
     OpticalRanges(16)=(Range=1600)
     OpticalRanges(17)=(Range=1700)
     OpticalRanges(18)=(Range=1800)
     OpticalRanges(19)=(Range=1900)
     OpticalRanges(20)=(Range=2000)
     bMechanicalAiming=true
     DHPenetrationTable(0)=2.900000
     DHPenetrationTable(1)=2.700000
     DHPenetrationTable(2)=2.400000
     DHPenetrationTable(3)=2.100000
     DHPenetrationTable(4)=1.900000
     DHPenetrationTable(5)=1.600000
     DHPenetrationTable(6)=1.300000
     DHPenetrationTable(7)=1.200000
     DHPenetrationTable(8)=1.000000
     DHPenetrationTable(9)=0.900000
     DHPenetrationTable(10)=0.700000
     ShellDiameter=5.700000
     bHasTracer=true
     PenetrationMag=630.000000
     ShellImpactDamage=Class'DH_Guns.DH_6PounderCannonShellDamageAP'
     ImpactDamage=295
     ShellHitDirtEffectClass=Class'ROEffects.TankHEHitDirtEffect'
     ShellHitSnowEffectClass=Class'ROEffects.TankHEHitSnowEffect'
     ShellHitWoodEffectClass=Class'ROEffects.TankHEHitWoodEffect'
     ShellHitRockEffectClass=Class'ROEffects.TankHEHitRockEffect'
     ShellHitWaterEffectClass=Class'ROEffects.TankHEHitWaterEffect'
     BallisticCoefficient=1.190000
     Speed=50152.000000
     MaxSpeed=50152.000000
     Damage=250.000000
     DamageRadius=600.000000
     MyDamageType=Class'DH_Guns.DH_6PounderCannonShellDamageHE'
     Tag="Mk.X HE-T"
}
