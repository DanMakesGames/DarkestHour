//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_GMCTruckTransport extends DH_ROWheeledVehicle;

#exec OBJ LOAD FILE=..\Animations\DH_GMCTruck_anm.ukx
#exec OBJ LOAD FILE=..\Textures\DH_Allied_MilitarySM.utx

//resupply attachment code
var     DH_GMCTruckResupplyAttachment     ResupplyAttach;
var()   name                              ResupplyAttachBone;

var     DH_GMCTruckDecoAttachment         DecorationAttach;
var()   name                              DecorationAttachBone;


static function StaticPrecache(LevelInfo L)
{
        Super.StaticPrecache(L);

    L.AddPrecacheMaterial(Material'DH_Allied_MilitarySM.American.GMC');

}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Material'DH_Allied_MilitarySM.American.GMC');
    Super.UpdatePrecacheMaterials();
}

simulated function PostBeginPlay()
{
     super.PostBeginPlay();

     if (ResupplyAttach == none)
     {
           ResupplyAttach = Spawn(class 'DH_GMCTruckResupplyAttachment');
           AttachToBone(ResupplyAttach, ResupplyAttachBone);
     }

     if (DecorationAttach == none)
     {
           DecorationAttach = Spawn(class 'DH_GMCTruckDecoAttachment');
           AttachToBone(DecorationAttach, DecorationAttachBone);
     }

}

simulated function Destroyed()
{

    if (ResupplyAttach != none)
        ResupplyAttach.Destroy();

    if (DecorationAttach != none)
        DecorationAttach.Destroy();

    super.Destroyed();
}

simulated event DestroyAppearance()
{

    if (ResupplyAttach != none)
    {
        ResupplyAttach.Destroy();
    }

    Super.DestroyAppearance();
}

// Overridden due to the Onslaught team lock not working in RO
function bool TryToDrive(Pawn P)
{
    local int x;

    //don't allow vehicle to be stolen when somebody is in a turret
    if (!bTeamLocked && P.GetTeamNum() != VehicleTeam)
    {
        for (x = 0; x < WeaponPawns.length; x++)
            if (WeaponPawns[x].Driver != none)
            {
                DenyEntry(P, 2);
                return false;
            }
    }

    if (P.bIsCrouched ||  bNonHumanControl || (P.Controller == none) || (Driver != none) || (P.DrivenVehicle != none) || !P.Controller.bIsPlayer
         || P.IsA('Vehicle') || Health <= 0 || (P.Weapon != none && P.Weapon.IsInState('Reloading')))
        return false;

    if (!Level.Game.CanEnterVehicle(self, P))
        return false;

    // Check vehicle Locking....
    if (bTeamLocked && (P.GetTeamNum() != VehicleTeam))
    {
        DenyEntry(P, 1);
        return false;
    }
    else if (bMustBeTankCommander && !ROPlayerReplicationInfo(P.Controller.PlayerReplicationInfo).RoleInfo.bCanBeTankCrew && P.IsHumanControlled())
    {
       DenyEntry(P, 0);
       return false;
    }
    else
    {
        if (bEnterringUnlocks && bTeamLocked)
            bTeamLocked = false;

        KDriverEnter(P);
        return true;
    }
}

defaultproperties
{
     ResupplyAttachBone="supply"
     DecorationAttachBone="Deco"
     EngineHealthMax=35
     bResupplyVehicle=true
     WheelSoftness=0.025000
     WheelPenScale=1.200000
     WheelPenOffset=0.010000
     WheelRestitution=0.100000
     WheelInertia=0.100000
     WheelLongFrictionFunc=(Points=(,(InVal=100.000000,OutVal=1.000000),(InVal=200.000000,OutVal=0.900000),(InVal=10000000000.000000,OutVal=0.900000)))
     WheelLongSlip=0.001000
     WheelLatSlipFunc=(Points=(,(InVal=30.000000,OutVal=0.009000),(InVal=45.000000),(InVal=10000000000.000000)))
     WheelLongFrictionScale=1.100000
     WheelLatFrictionScale=1.350000
     WheelHandbrakeSlip=1.100000
     WheelHandbrakeFriction=0.100000
     WheelSuspensionTravel=15.000000
     WheelSuspensionMaxRenderTravel=15.000000
     FTScale=0.030000
     ChassisTorqueScale=0.400000
     MinBrakeFriction=4.000000
     MaxSteerAngleCurve=(Points=((OutVal=35.000000),(InVal=1500.000000,OutVal=20.000000),(InVal=1000000000.000000,OutVal=15.000000)))
     TorqueCurve=(Points=((OutVal=1.000000),(InVal=200.000000,OutVal=0.750000),(InVal=1500.000000,OutVal=2.000000),(InVal=2200.000000)))
     GearRatios(0)=-0.200000
     GearRatios(1)=0.200000
     GearRatios(2)=0.350000
     GearRatios(3)=0.650000
     GearRatios(4)=0.850000
     TransRatio=0.120000
     ChangeUpPoint=1990.000000
     ChangeDownPoint=1000.000000
     LSDFactor=1.000000
     EngineBrakeFactor=0.000100
     EngineBrakeRPMScale=0.100000
     MaxBrakeTorque=20.000000
     SteerSpeed=100.000000
     TurnDamping=35.000000
     StopThreshold=100.000000
     HandbrakeThresh=200.000000
     EngineInertia=0.100000
     IdleRPM=500.000000
     EngineRPMSoundRange=5000.000000
     SteerBoneName="WheelDrive"
     RevMeterScale=4000.000000
     ExhaustEffectClass=Class'ROEffects.ExhaustPetrolEffect'
     ExhaustEffectLowClass=Class'ROEffects.ExhaustPetrolEffect_simple'
     ExhaustPipes(0)=(ExhaustPosition=(X=-150.000000,Y=-35.000000,Z=-12.000000),ExhaustRotation=(Pitch=36000,Yaw=5000))
     ExhaustPipes(1)=(ExhaustPosition=(X=-150.000000,Y=35.000000,Z=-12.000000),ExhaustRotation=(Pitch=36000,Yaw=5000))
     PassengerWeapons(0)=(WeaponPawnClass=Class'DH_Vehicles.DH_GMCTruckPassengerOne',WeaponBone="passenger1")
     PassengerWeapons(1)=(WeaponPawnClass=Class'DH_Vehicles.DH_GMCTruckPassengerFour',WeaponBone="passenger_l_5")
     PassengerWeapons(2)=(WeaponPawnClass=Class'DH_Vehicles.DH_GMCTruckPassengerSeven',WeaponBone="passenger_r_5")
     IdleSound=SoundGroup'Vehicle_Engines.sdkfz251.sdkfz251_engine_loop'
     StartUpSound=Sound'Vehicle_Engines.sdkfz251.sdkfz251_engine_start'
     ShutDownSound=Sound'Vehicle_Engines.sdkfz251.sdkfz251_engine_stop'
     DestroyedVehicleMesh=StaticMesh'DH_allies_vehicles_stc.Trucks.GMC_destroyed'
     DisintegrationEffectClass=Class'ROEffects.ROVehicleObliteratedEmitter'
     DisintegrationEffectLowClass=Class'ROEffects.ROVehicleObliteratedEmitter_simple'
     DisintegrationHealth=-10000.000000
     DestructionLinearMomentum=(Min=100.000000,Max=350.000000)
     DestructionAngularMomentum=(Max=150.000000)
     DamagedEffectScale=0.800000
     DamagedEffectOffset=(X=135.000000,Z=65.000000)
     ImpactDamageThreshold=5000.000000
     ImpactDamageMult=0.001000
     VehicleTeam=1
     SteeringScaleFactor=4.000000
     BeginningIdleAnim=
     DriverPositions(0)=(PositionMesh=SkeletalMesh'DH_GMCTruck_anm.GMCTruck_body',ViewPitchUpLimit=10000,ViewPitchDownLimit=60000,ViewPositiveYawLimit=20000,ViewNegativeYawLimit=-20000,bExposed=true,ViewFOV=90.000000)
     InitialPositionIndex=0
     VehicleHudImage=Texture'DH_InterfaceArt_tex.Tank_Hud.GMC_body'
     VehicleHudOccupantsX(0)=0.450000
     VehicleHudOccupantsX(1)=0.550000
     VehicleHudOccupantsX(2)=0.450000
     VehicleHudOccupantsX(3)=0.550000
     VehicleHudOccupantsY(0)=0.400000
     VehicleHudOccupantsY(1)=0.400000
     VehicleHudOccupantsY(2)=0.750000
     VehicleHudOccupantsY(3)=0.750000
     VehicleHudEngineY=0.250000
     VehHitpoints(0)=(PointBone="body",PointOffset=(X=55.000000,Y=-23.000000,Z=78.000000),bPenetrationPoint=false)
     VehHitpoints(1)=(PointBone="Engine",DamageMultiplier=1.000000)
     VehHitpoints(2)=(PointRadius=18.000000,PointScale=1.000000,PointBone="wheel_FL",DamageMultiplier=1.000000,HitPointType=HP_Engine)
     VehHitpoints(3)=(PointRadius=18.000000,PointScale=1.000000,PointBone="wheel_FR",DamageMultiplier=1.000000,HitPointType=HP_Engine)
     VehHitpoints(4)=(PointRadius=40.000000,PointScale=1.000000,PointBone="body",PointOffset=(X=-80.000000,Z=90.000000),DamageMultiplier=5.000000,HitPointType=HP_AmmoStore)
     EngineHealth=35
     bMultiPosition=false
     DriverAttachmentBone="driver_player"
     Begin Object Class=SVehicleWheel Name=RFWheel
         SteerType=VST_Steered
         BoneName="wheel_FR"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_F_R"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(0)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.RFWheel'

     Begin Object Class=SVehicleWheel Name=LFWheel
         SteerType=VST_Steered
         BoneName="wheel_FL"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_F_L"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(1)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.LFWheel'

     Begin Object Class=SVehicleWheel Name=MRWheel
         bPoweredWheel=true
         bHandbrakeWheel=true
         BoneName="wheel_MR"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_M_R"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(2)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.MRWheel'

     Begin Object Class=SVehicleWheel Name=MLWheel
         bPoweredWheel=true
         bHandbrakeWheel=true
         BoneName="wheel_ML"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_M_L"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(3)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.MLWheel'

     Begin Object Class=SVehicleWheel Name=RRWheel
         bPoweredWheel=true
         bHandbrakeWheel=true
         BoneName="wheel_RR"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_R_R"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(4)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.RRWheel'

     Begin Object Class=SVehicleWheel Name=LRWheel
         bPoweredWheel=true
         bHandbrakeWheel=true
         BoneName="wheel_LR"
         BoneRollAxis=AXIS_Y
         WheelRadius=26.000000
         SupportBoneName="Axle_R_L"
         SupportBoneAxis=AXIS_X
     End Object
     Wheels(5)=SVehicleWheel'DH_Vehicles.DH_GMCTruckTransport.LRWheel'

     VehicleMass=3.500000
     bHasHandbrake=true
     bFPNoZFromCameraPitch=true
     DrivePos=(X=6.000000,Z=2.000000)
     DriveAnim="VUC_driver_idle_open"
     ExitPositions(0)=(X=50.000000,Y=-125.000000,Z=75.000000)
     ExitPositions(1)=(X=50.000000,Y=125.000000,Z=75.000000)
     ExitPositions(2)=(Y=-125.000000,Z=75.000000)
     ExitPositions(3)=(Y=125.000000,Z=75.000000)
     EntryRadius=375.000000
     FPCamPos=(X=120.000000,Y=-21.000000,Z=17.000000)
     TPCamDistance=500.000000
     CenterSpringForce="SpringONSSRV"
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=50.000000)
     DriverDamageMult=1.000000
     VehiclePositionString="in a GMC 2.5 Ton Truck"
     VehicleNameString="GMC 2.5 Ton Truck"
     MaxDesireability=0.120000
     FlagBone="Mg_placement"
     FlagRotation=(Yaw=32768)
     GroundSpeed=325.000000
     PitchUpLimit=5000
     PitchDownLimit=49000
     HealthMax=150.000000
     Health=150
     Mesh=SkeletalMesh'DH_GMCTruck_anm.GMCTruck_body'
     Skins(0)=Texture'DH_Allied_MilitarySM.American.GMC'
     SoundRadius=800.000000
     TransientSoundRadius=1500.000000
     CollisionRadius=175.000000
     CollisionHeight=40.000000
     Begin Object Class=KarmaParamsRBFull Name=KParams0
         KInertiaTensor(0)=1.000000
         KInertiaTensor(3)=3.000000
         KInertiaTensor(5)=3.000000
         KLinearDamping=0.050000
         KAngularDamping=0.050000
         KStartEnabled=true
         bKNonSphericalInertia=true
         bHighDetailOnly=false
         bClientOnly=false
         bKDoubleTickRate=true
         bDestroyOnWorldPenetrate=true
         bDoSafetime=true
         KFriction=0.500000
         KImpactThreshold=700.000000
     End Object
     KParams=KarmaParamsRBFull'DH_Vehicles.DH_GMCTruckTransport.KParams0'

}
