//==============================================================================
// DH_ShermanCannon_M4A3E2
//
// Darkest Hour Source - (c) Darkest Hour Team 2010
// Red Orchestra Source - (c) Tripwire Interactive 2006
//
// American M4A3E2(75)W (Sherman 'Jumbo') 75mm assault tank cannon
//==============================================================================
class DH_ShermanCannon_M4A3E2 extends DH_ROTankCannon;

// Special tracer handling for this type of cannon
simulated function UpdateTracer()
{
    local rotator SpawnDir;

    if (Level.NetMode == NM_DedicatedServer || !bUsesTracers)
        return;


    if (Level.TimeSeconds > mLastTracerTime + mTracerInterval)
    {
        if (Instigator != none && Instigator.IsLocallyControlled())
        {
            SpawnDir = WeaponFireRotation;
        }
        else
        {
            SpawnDir = GetBoneRotation(WeaponFireAttachmentBone);
        }

        if (Instigator != none && !Instigator.PlayerReplicationInfo.bBot)
        {
            SpawnDir.Pitch += AddedPitch;
        }

        Spawn(DummyTracerClass,,, WeaponFireLocation, SpawnDir);

        mLastTracerTime = Level.TimeSeconds;
    }
}

// American tanks must use the actual sight markings to aim!
simulated function int GetRange()
{
    return RangeSettings[0];
}

// Disable clicking sound for range adjustment
function IncrementRange()
{
    if (CurrentRangeIndex < RangeSettings.Length - 1)
    {
        if (Instigator != none && Instigator.Controller != none && ROPlayer(Instigator.Controller) != none)
            //ROPlayer(Instigator.Controller).ClientPlaySound(sound'ROMenuSounds.msfxMouseClick',false,,SLOT_Interface);

        CurrentRangeIndex++;
    }
}

function DecrementRange()
{
    if (CurrentRangeIndex > 0)
    {
        if (Instigator != none && Instigator.Controller != none && ROPlayer(Instigator.Controller) != none)
            //ROPlayer(Instigator.Controller).ClientPlaySound(sound'ROMenuSounds.msfxMouseClick',false,,SLOT_Interface);

        CurrentRangeIndex --;
    }
}

defaultproperties
{
     InitialTertiaryAmmo=5
     TertiaryProjectileClass=Class'DH_Vehicles.DH_ShermanCannonShellSmoke'
     SecondarySpread=0.001750
     TertiarySpread=0.003600
     ManualRotationsPerSecond=0.016700
     PoweredRotationsPerSecond=0.040000
     FrontArmorFactor=16.600000
     RightArmorFactor=15.200000
     LeftArmorFactor=15.200000
     RearArmorFactor=15.200000
     FrontLeftAngle=320.000000
     FrontRightAngle=40.000000
     RearRightAngle=140.000000
     RearLeftAngle=220.000000
     ReloadSoundOne=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_01'
     ReloadSoundTwo=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_02'
     ReloadSoundThree=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_03'
     ReloadSoundFour=Sound'DH_Vehicle_Reloads.Reloads.reload_01s_04'
     CannonFireSound(0)=SoundGroup'DH_AlliedVehicleSounds.75mm.DHM3-75mm'
     CannonFireSound(1)=SoundGroup'DH_AlliedVehicleSounds.75mm.DHM3-75mm'
     CannonFireSound(2)=SoundGroup'DH_AlliedVehicleSounds.75mm.DHM3-75mm'
     ProjectileDescriptions(0)="APCBC"
     ProjectileDescriptions(2)="Smoke"
     RangeSettings(1)=400
     RangeSettings(2)=800
     RangeSettings(3)=1200
     RangeSettings(4)=1600
     RangeSettings(5)=2000
     RangeSettings(6)=2400
     RangeSettings(7)=2800
     RangeSettings(8)=3200
     RangeSettings(9)=4200
     AddedPitch=68
     ReloadSound=Sound'Vehicle_reloads.Reloads.MG34_ReloadHidden'
     NumAltMags=5
     DummyTracerClass=Class'DH_Vehicles.DH_30CalVehicleClientTracer'
     mTracerInterval=0.600000
     bUsesTracers=true
     bAltFireTracersOnly=true
     VehHitpoints(0)=(PointRadius=9.000000,PointScale=1.000000,PointBone="com_player",PointOffset=(Z=-2.000000))
     VehHitpoints(1)=(PointRadius=15.000000,PointScale=1.000000,PointBone="com_player",PointOffset=(Z=-24.000000))
     hudAltAmmoIcon=Texture'InterfaceArt_tex.HUD.mg42_ammo'
     YawBone="Turret"
     PitchBone="Gun"
     PitchUpLimit=15000
     PitchDownLimit=45000
     WeaponFireAttachmentBone="Gun"
     GunnerAttachmentBone="com_attachment"
     WeaponFireOffset=115.000000
     AltFireOffset=(X=25.000000,Y=-23.000000,Z=3.500000)
     RotationsPerSecond=0.040000
     bAmbientAltFireSound=true
     FireInterval=4.200000
     AltFireInterval=0.120000
     EffectEmitterClass=Class'ROEffects.TankCannonFireEffect'
     AmbientEffectEmitterClass=Class'ROVehicles.TankMGEmitter'
     bAmbientEmitterAltFireOnly=true
     FireSoundVolume=512.000000
     AltFireSoundClass=SoundGroup'DH_AlliedVehicleSounds2.30Cal.V30cal_loop01'
     AltFireSoundScaling=3.000000
     RotateSound=Sound'DH_AlliedVehicleSounds.Sherman.ShermanTurretTraverse'
     AltFireEndSound=SoundGroup'DH_AlliedVehicleSounds2.30Cal.V30cal_end01'
     FireForce="Explosion05"
     ProjectileClass=Class'DH_Vehicles.DH_ShermanCannonShell'
     AltFireProjectileClass=Class'DH_Vehicles.DH_30CalVehicleBullet'
     ShakeRotMag=(Z=50.000000)
     ShakeRotRate=(Z=1000.000000)
     ShakeRotTime=4.000000
     ShakeOffsetMag=(Z=1.000000)
     ShakeOffsetRate=(Z=100.000000)
     ShakeOffsetTime=10.000000
     AltShakeRotMag=(X=0.010000,Y=0.010000,Z=0.010000)
     AltShakeRotRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     AltShakeRotTime=2.000000
     AltShakeOffsetMag=(X=0.010000,Y=0.010000,Z=0.010000)
     AltShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     AltShakeOffsetTime=2.000000
     AIInfo(0)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.500000)
     AIInfo(1)=(bLeadTarget=true,WarnTargetPct=0.750000,RefireRate=0.015000)
     CustomPitchUpLimit=4551
     CustomPitchDownLimit=63715
     BeginningIdleAnim="Periscope_idle"
     InitialPrimaryAmmo=35
     InitialSecondaryAmmo=50
     InitialAltAmmo=200
     PrimaryProjectileClass=Class'DH_Vehicles.DH_ShermanCannonShell'
     SecondaryProjectileClass=Class'DH_Vehicles.DH_ShermanCannonShellHE'
     Mesh=SkeletalMesh'DH_ShermanM4A3E2_anm.ShermanM4A3E2_turret_ext'
     SoundVolume=130
     SoundRadius=200.000000
}
