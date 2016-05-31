//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2016
//==============================================================================

class DHCannonShellSmoke extends DHCannonShellHE
    abstract;

var  class<Emitter> SmokeEmitterClass;
var  sound          SmokeIgniteSound;
var  sound          SmokeLoopSound;
var  float          SmokeSoundDuration;

// Matt: removed as unnecessary:
// var()  float      DestroyTimer;
// var    bool       bCalledDestroy;
// var    Emitter    SmokeEmitter;

// Modified to add smoke effects
simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal, optional float ActualLocationAdjustment)
{
    super.SpawnExplosionEffects(HitLocation, HitNormal, ActualLocationAdjustment);

    if (Level.NetMode != NM_DedicatedServer && !bCollided) // check on !bCollided is in case the Super flags no more effects, e.g. if hit invisible BSP used as a network culler
    {
        Spawn(SmokeEmitterClass, self,, HitLocation, rotator(-HitNormal));
        PlaySound(SmokeIgniteSound, SLOT_NONE, 1.5,, 200.0);
        AmbientSound = SmokeLoopSound;
        AmbientVolumeScale = 1.0; // overriding defaults for shells, which are intended for their in-flight 'whistle' - this (& radius) match smoke grenade sounds
        SoundRadius = 200.0;
    }
}

// Matt: modified so actor is torn off & then destroyed on server, but persists for its LifeSpan on clients to play the smoke sound
simulated function HandleDestruction()
{
    bCollided = true;

    bTearOff = true; // stops any further replication, but client copies of actor persist to play the smoke sound

    if (Level.NetMode == NM_DedicatedServer)
    {
        LifeSpan = 1.0; // on a server this actor will be destroyed in 1 second, allowing time for bTearOff to replicate to clients
    }
    else
    {
        LifeSpan = SmokeSoundDuration; // this actor will persist as long as the smoke sound
    }

    SetCollision(false, false);
    bCollideWorld = false;
}

defaultproperties
{
    RoundType=RT_Smoke
    bAlwaysRelevant=true // has to be always relevant so that the smoke effect always gets spawned
    SmokeEmitterClass=class'DH_Effects.DHSmokeEffect_Shell'
    SmokeIgniteSound=sound'Inf_WeaponsTwo.smokegrenade.smoke_ignite'
    SmokeLoopSound=sound'Inf_WeaponsTwo.smokegrenade.smoke_loop'
    SmokeSoundDuration=33.0
    ImpactDamage=125
    BallisticCoefficient=0.6
    SpeedFudgeScale=0.75
    MaxSpeed=500.0
    Damage=75.0
    DamageRadius=50.0
    MyDamageType=class'DH_Engine.DHShellSmokeDamageType'
    LifeSpan=12.0
    AmbientGlow=50
//  SoundVolume=175 // Matt: removed as affects shell's flight 'whistle' & smoke sounds (i.e. AmbientSound), not the explosion sound volume (same with radius below)
//  SoundRadius=500.0
//  TransientSoundVolume=0.75 // Matt: removed as sound effects are the same as for other shells, except the explosion volume that we now control with ExplosionSoundVolume
//  TransientSoundRadius=750.0
    ExplosionSoundVolume=0.75
}
