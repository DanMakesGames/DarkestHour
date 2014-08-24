class EA_FireVolume extends PhysicsVolume;

var()   class<DamageType>   FireDamageType;
var()   int                 FireDamageAmount;

function CausePainTo(Actor Other)
{
    local float depth;
    local Pawn P;

    // FIXMEZONE figure out depth of actor, and base pain on that!!!
    depth = 1;
    P = Pawn(Other);

    if ( DamagePerSec > 0 )
    {
        if ( Region.Zone.bSoftKillZ && (Other.Physics != PHYS_Walking) )
            return;
        Other.TakeDamage(int(DamagePerSec * depth), None, Location, vect(0,0,0), DamageType);
        if ( P.Health <= 20 )
            Other.TakeDamage(int(FireDamageAmount * depth), None, Location, vect(0,0,0), FireDamageType);

        if ( (P != None) && (P.Controller != None) )
            P.Controller.PawnIsInPain(self);

    }
    else
    {
        if ( (P != None) && (P.Health < P.HealthMax) )
            P.Health = Min(P.HealthMax, P.Health - depth * DamagePerSec);
    }
}

defaultproperties
{
    FireDamageAmount=1
    DamagePerSec=20
    FireDamageType=class'DH_Engine.DH_BurningDamType'
    DamageType=class'FellLava'
    bPainCausing=True
    bWaterVolume=false
    bDestructive=True
    bNoInventory=true
    ViewFog=(X=0.5859375,Y=0.1953125,Z=0.078125)
    FluidFriction=+00004.000000
    LocationName="in fire"
    KExtraLinearDamping=0.8
    KExtraAngularDamping=0.1
    RemoteRole=ROLE_None
    bNoDelete=true
}
