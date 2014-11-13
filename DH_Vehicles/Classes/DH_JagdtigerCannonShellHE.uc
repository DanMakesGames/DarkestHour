//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_JagdtigerCannonShellHE extends DH_ROTankCannonShellHE;

defaultproperties
{
     ExplosionSound(0)=SoundGroup'Artillery.explosions.explo01'
     ExplosionSound(1)=SoundGroup'Artillery.explosions.explo02'
     ExplosionSound(2)=SoundGroup'Artillery.explosions.explo03'
     ExplosionSound(3)=SoundGroup'Artillery.explosions.explo04'
     MechanicalRanges(1)=(Range=100,RangeValue=16.000000)
     MechanicalRanges(2)=(Range=200,RangeValue=20.000000)
     MechanicalRanges(3)=(Range=300,RangeValue=26.000000)
     MechanicalRanges(4)=(Range=400,RangeValue=32.000000)
     MechanicalRanges(5)=(Range=500,RangeValue=42.000000)
     MechanicalRanges(6)=(Range=600,RangeValue=48.000000)
     MechanicalRanges(7)=(Range=700,RangeValue=54.000000)
     MechanicalRanges(8)=(Range=800,RangeValue=62.000000)
     MechanicalRanges(9)=(Range=900,RangeValue=70.000000)
     MechanicalRanges(10)=(Range=1000,RangeValue=74.000000)
     MechanicalRanges(11)=(Range=1100,RangeValue=86.000000)
     MechanicalRanges(12)=(Range=1200,RangeValue=90.000000)
     MechanicalRanges(13)=(Range=1300,RangeValue=100.000000)
     MechanicalRanges(14)=(Range=1400,RangeValue=110.000000)
     MechanicalRanges(15)=(Range=1500,RangeValue=116.000000)
     MechanicalRanges(16)=(Range=1600,RangeValue=124.000000)
     MechanicalRanges(17)=(Range=1700,RangeValue=134.000000)
     MechanicalRanges(18)=(Range=1800,RangeValue=136.000000)
     MechanicalRanges(19)=(Range=1900,RangeValue=148.000000)
     MechanicalRanges(20)=(Range=2000,RangeValue=154.000000)
     MechanicalRanges(21)=(Range=2200,RangeValue=169.000000)
     MechanicalRanges(22)=(Range=2400,RangeValue=183.000000)
     MechanicalRanges(23)=(Range=2600,RangeValue=198.000000)
     MechanicalRanges(24)=(Range=2800,RangeValue=212.000000)
     MechanicalRanges(25)=(Range=3000,RangeValue=227.000000)
     bMechanicalAiming=true
     DHPenetrationTable(0)=10.500000
     DHPenetrationTable(1)=9.900000
     DHPenetrationTable(2)=9.500000
     DHPenetrationTable(3)=8.900000
     DHPenetrationTable(4)=8.500000
     DHPenetrationTable(5)=8.100000
     DHPenetrationTable(6)=7.700000
     DHPenetrationTable(7)=7.300000
     DHPenetrationTable(8)=6.700000
     DHPenetrationTable(9)=6.200000
     DHPenetrationTable(10)=5.900000
     ShellDiameter=12.800000
     bIsAlliedShell=false
     PenetrationMag=1500.000000
     ShellImpactDamage=Class'DH_Vehicles.DH_JagdtigerCannonShellDamageAP'
     ImpactDamage=900
     ShellDeflectEffectClass=Class'ROEffects.ROArtilleryDirtEmitter'
     ShellHitDirtEffectClass=Class'ROEffects.ROArtilleryDirtEmitter'
     ShellHitSnowEffectClass=Class'ROEffects.ROArtillerySnowEmitter'
     ShellHitWoodEffectClass=Class'ROEffects.ROArtilleryDirtEmitter'
     ShellHitRockEffectClass=Class'ROEffects.ROArtilleryDirtEmitter'
     ShellHitWaterEffectClass=Class'ROEffects.ROArtilleryWaterEmitter'
     BallisticCoefficient=3.900000
     Speed=53110.000000
     MaxSpeed=53110.000000
     Damage=700.000000
     DamageRadius=2715.000000
     MyDamageType=Class'DH_Vehicles.DH_JagdtigerCannonShellDamageHE'
     Tag="Schw.Spgr.Patr"
}
