//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_Stug3GMountedMG extends ROVehicleWeapon;


var     bool  bReloading;  // This MG is currently reloading
var     int   NumMags;     // Number of mags carried for this MG;
var()   float ReloadLength;// Length of the reload animation. Sorry for the literal, but the Hud Overlay isn't spawned on the server.

// Stuff for fire effects - Ch!cKeN
var()   name                                    FireAttachBone;
var()   vector                                  FireEffectOffset;
var     class<VehicleDamagedEffect>             FireEffectClass;
var     VehicleDamagedEffect                    HullMGFireEffect;
var     bool                                    bOnFire;   // Set by Treadcraft base to notify when to start fire effects
var     float                                   BurnTime;

var     class<DamageType>   VehicleBurningDamType;
var     float               PlayerFireDamagePerSec;

replication
{
    // Functions server can call.
    reliable if (Role==ROLE_Authority)
        ClientDoReload;

    reliable if (bNetDirty && bNetOwner && Role == ROLE_Authority)
        bReloading, NumMags;

    reliable if (bNetDirty && Role == ROLE_Authority)
        bOnFire;
}

simulated function Tick(float DeltaTime)
{

    Super.Tick(DeltaTime);

    if (bOnFire && HullMGFireEffect == none)
    {
        // Lets randomise the fire start times to desync them with the driver and engine ones
        if (Level.TimeSeconds - BurnTime > 0.2)
        {
            if (FRand() < 0.1)
            {
                HullMGFireEffect = Spawn(FireEffectClass);
                AttachToBone(HullMGFireEffect, FireAttachBone);
                HullMGFireEffect.SetRelativeLocation(FireEffectOffset);
                HullMGFireEffect.UpdateDamagedEffect(true, 0, false, false);
            }
            BurnTime = Level.TimeSeconds;
        }
    }
}

// Limit the left and right movement of the driver
simulated function int LimitYaw(int yaw)
{
    local int NewYaw;
    local ROVehicleWeaponPawn PwningPawn;

    PwningPawn = ROVehicleWeaponPawn(Owner);

    if (!bLimitYaw)
    {
        return yaw;
    }

    NewYaw = yaw;

    if (PwningPawn != none)
    {
        if (yaw > PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit)
        {
            NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewPositiveYawLimit;
        }
        else if (yaw < PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit)
        {
            NewYaw = PwningPawn.DriverPositions[PwningPawn.DriverPositionIndex].ViewNegativeYawLimit;
        }
    }
    else
    {
        if (yaw > MaxPositiveYaw)
        {
            NewYaw = MaxPositiveYaw;
        }
        else if (yaw < MaxNegativeYaw)
        {
            NewYaw = MaxNegativeYaw;
        }
    }

    return NewYaw;
}

// Returns true if this weapon is ready to fire
simulated function bool ReadyToFire(bool bAltFire)
{
    if (bReloading)
        return false;

    return super.ReadyToFire(bAltFire);
}

function CeaseFire(Controller C, bool bWasAltFire)
{
    super.CeaseFire(C, bWasAltFire);

    if (!bReloading && !HasAmmo(0))
        HandleReload();
}

function HandleReload()
{
    if (NumMags > 0 && !bReloading)
    {
        bReloading = true;
        NumMags--;
        ClientDoReload();
        NetUpdateTime = Level.TimeSeconds - 1;

        //log("Reloading duration = "$VehicleWeaponPawn(Owner).HUDOverlay.GetAnimDuration('Bipod_Reload_s', 1.0));
        //SetTimer(VehicleWeaponPawn(Owner).HUDOverlay.GetAnimDuration('reload', 1.0), false);
        SetTimer(ReloadLength, false);
    }
}

// Play the reload animation on the client
simulated function ClientDoReload()
{
    if (Owner != none && VehicleWeaponPawn(Owner) != none && VehicleWeaponPawn(Owner).HUDOverlay != none)
        VehicleWeaponPawn(Owner).HUDOverlay.PlayAnim('Bipod_Reload_s');
}

simulated function Timer()
{
   if (bReloading)
   {
        if (Role == ROLE_Authority)
        {
            bReloading=false;
            MainAmmoCharge[0] = InitialPrimaryAmmo;
            NetUpdateTime = Level.TimeSeconds - 1;
        }
   }
}

event bool AttemptFire(Controller C, bool bAltFire)
{
    if (Role != ROLE_Authority || bForceCenterAim)
        return false;

    if (FireCountdown <= 0)
    {
        CalcWeaponFire(bAltFire);
        if (bCorrectAim)
            WeaponFireRotation = AdjustAim(bAltFire);

        if (bAltFire)
        {
            if (AltFireSpread > 0)
                WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*AltFireSpread);
        }
        else if (Spread > 0)
        {
            WeaponFireRotation = rotator(vector(WeaponFireRotation) + VRand()*FRand()*Spread);
        }

        DualFireOffset *= -1;

        Instigator.MakeNoise(1.0);
        if (bAltFire)
        {
            if (!ConsumeAmmo(2))
            {
                VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
                return false;
            }
            FireCountdown = AltFireInterval;
            AltFire(C);
        }
        else
        {
            if (bMultipleRoundTypes)
            {
                if (ProjectileClass == PrimaryProjectileClass)
                {
                    if (!ConsumeAmmo(0))
                    {
                        VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
                        return false;
                    }
                }
                else if (ProjectileClass == SecondaryProjectileClass)
                {
                    if (!ConsumeAmmo(1))
                    {
                        VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
                        return false;
                    }
                }
            }
            else if (!ConsumeAmmo(0))
            {
                VehicleWeaponPawn(Owner).ClientVehicleCeaseFire(bAltFire);
                HandleReload();
                return false;
            }

            FireCountdown = FireInterval;
            Fire(C);
        }
        AimLockReleaseTime = Level.TimeSeconds + FireCountdown * FireIntervalAimLock;

        return true;
    }

    return false;
}

// Fill the ammo up to the initial ammount
function bool GiveInitialAmmo()
{
    local bool bDidResupply;

    if (NumMags != default.NumMags)
    {
        bDidResupply = true;
    }

    MainAmmoCharge[0] = InitialPrimaryAmmo;
    MainAmmoCharge[1] = InitialSecondaryAmmo;
    AltAmmoCharge = InitialAltAmmo;
    NumMags = default.NumMags;

    return bDidResupply;
}

simulated function int getNumMags()
{
    return NumMags;
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (HullMGFireEffect != none)
        HullMGFireEffect.Destroy();
}

defaultproperties
{
     NumMags=8
     ReloadLength=6.590000
     FireAttachBone="gunner_int"
     FireEffectOffset=(Z=5.000000)
     FireEffectClass=Class'ROEngine.VehicleDamagedEffect'
     VehicleBurningDamType=Class'DH_VehicleBurningDamType'
     DummyTracerClass=Class'DH_Vehicles.DH_MG34VehicleClientTracer'
     mTracerInterval=0.495867
     bUsesTracers=true
     VehHitpoints(0)=(PointRadius=9.000000,PointScale=1.000000,PointBone="loader_attachment",PointOffset=(X=10.000000,Y=-5.000000,Z=23.000000))
     VehHitpoints(1)=(PointRadius=15.000000,PointScale=1.000000,PointBone="loader_attachment",PointOffset=(X=10.000000,Y=-5.000000,Z=1.000000))
     bIsMountedTankMG=true
     hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.mg42_ammo'
     YawBone="mg_pitch"
     PitchBone="mg_pitch"
     PitchUpLimit=10000
     PitchDownLimit=50000
     WeaponFireAttachmentBone="tip"
     GunnerAttachmentBone="loader_attachment"
     RotationsPerSecond=0.050000
     bInstantRotation=true
     bDoOffsetTrace=true
     bAmbientFireSound=true
     bIsRepeatingFF=true
     Spread=0.002000
     FireInterval=0.070580
     AltFireInterval=0.070580
     AmbientEffectEmitterClass=Class'ROVehicles.VehicleMGEmitter'
     FireSoundClass=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_loop'
     AmbientSoundScaling=5.000000
     FireEndSound=SoundGroup'DH_WeaponSounds.mg34.mg34_fire_end'
     FireForce="minifireb"
     DamageType=Class'ROGame.ROVehMountedMGDamType'
     DamageMin=25
     DamageMax=25
     TraceRange=15000.000000
     ProjectileClass=Class'DH_Vehicles.DH_MG34VehicleBullet'
     ShakeRotMag=(X=25.000000,Z=10.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=0.500000,Z=0.200000)
     ShakeOffsetRate=(X=500.000000,Y=500.000000,Z=500.000000)
     ShakeOffsetTime=2.000000
     AIInfo(0)=(bLeadTarget=true,bFireOnRelease=true,aimerror=800.000000,RefireRate=0.070580)
     CustomPitchUpLimit=4500
     CustomPitchDownLimit=63500
     MaxPositiveYaw=5500
     MaxNegativeYaw=-5500
     bLimitYaw=true
     BeginningIdleAnim="loader_button_idle"
     InitialPrimaryAmmo=75
     CullDistance=8000.000000
     Mesh=SkeletalMesh'DH_Stug3G_anm.Stug_mg34_ext'
     Skins(0)=Texture'DH_VehiclesGE_tex2.ext_vehicles.Stug3g_body_ext'
     Skins(2)=Texture'Weapons3rd_tex.German.mg34_world'
     bCollideActors=true
     bBlockActors=true
     bProjTarget=true
     bBlockZeroExtentTraces=true
     bBlockNonZeroExtentTraces=true
}
