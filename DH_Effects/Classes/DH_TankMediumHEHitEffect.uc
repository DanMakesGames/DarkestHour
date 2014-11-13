//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_TankMediumHEHitEffect extends Emitter;

//------------------------------------------------------------------------------
// called client side to add screen shake effect for satchel explosions
//------------------------------------------------------------------------------

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         TriggerDisabled=false
         ResetOnTrigger=true
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.200000
         MaxParticles=5
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=300.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=6.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=14.000000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=60.000000),Z=(Min=45.000000,Max=50.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.LSmoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         VelocityLossRange=(Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(0)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         TriggerDisabled=false
         ResetOnTrigger=true
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.510000
         MaxParticles=5
         StartLocationOffset=(Z=150.000000)
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=30.000000,Max=50.000000),Y=(Min=30.000000,Max=50.000000),Z=(Min=45.000000,Max=50.000000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.LSmoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=250.000000,Max=750.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         TriggerDisabled=false
         ResetOnTrigger=true
         Acceleration=(X=200.000000,Y=200.000000,Z=50.000000)
         ColorScale(0)=(Color=(B=107,G=107,R=107,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=25.000000,Max=35.000000),Y=(Min=25.000000,Max=35.000000),Z=(Min=45.000000,Max=50.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=500.000000,Max=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=true
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         TriggerDisabled=false
         ResetOnTrigger=true
         Acceleration=(X=50.000000,Y=50.000000,Z=50.000000)
         ColorScale(0)=(Color=(A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.020000
         FadeInEndTime=0.210000
         MaxParticles=50
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
         AddLocationFromOtherEmitter=4
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.150000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=5.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000),Y=(Min=5.000000,Max=10.000000),Z=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=300.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=3.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=10.000000,Max=10.000000))
         VelocityLossRange=(Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(3)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=true
         RespawnDeadParticles=false
         UseRevolution=true
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         UseRandomSubdivision=true
         Acceleration=(Z=-1000.000000)
         DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
         ColorScale(0)=(Color=(B=25,G=25,R=25,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=82,G=84,R=95,A=255))
         FadeOutStartTime=1.400000
         MaxParticles=5000
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.BulletHits.rock_chunks'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-2000.000000,Max=2000.000000),Y=(Min=-2000.000000,Max=2000.000000),Z=(Min=750.000000,Max=1000.000000))
     End Object
     Emitters(4)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=true
         RespawnDeadParticles=false
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         BlendBetweenSubdivisions=true
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.048000
         MaxParticles=3
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.impact_2frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(5)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         Acceleration=(Z=-75.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.098000
         FadeInEndTime=0.080000
         MaxParticles=4
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.explosion_1frame'
         LifetimeRange=(Min=0.500000,Max=0.600000)
         StartVelocityRange=(Z=(Min=1000.000000,Max=1000.000000))
     End Object
     Emitters(6)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=true
         FadeIn=true
         RespawnDeadParticles=false
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         BlendBetweenSubdivisions=true
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.018000
         FadeInEndTime=0.008000
         MaxParticles=1
         StartLocationOffset=(Z=200.000000)
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=4.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.explosions.impact_2frame'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.200000,Max=0.200000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
         StartVelocityRange=(Z=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(7)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseColorScale=true
         FadeOut=true
         RespawnDeadParticles=false
         SpinParticles=true
         UseSizeScale=true
         UseRegularSizeScale=false
         UniformSize=true
         AutomaticInitialSpawning=false
         Acceleration=(X=50.000000,Y=50.000000,Z=0.500000)
         ColorScale(0)=(Color=(B=104,G=123,R=132,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.990000
         MaxParticles=8
         StartLocationRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Min=-0.500000,Max=0.500000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=25.000000),Y=(Min=25.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'Effects_Tex.explosions.DSmoke_2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000))
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(8)=SpriteEmitter'DH_Effects.DH_TankMediumHEHitEffect.SpriteEmitter8'

     bNoDelete=false
     bNetTemporary=true
     LifeSpan=16.000000
     Style=STY_Masked
     bHardAttach=true
     bDirectional=true
}
