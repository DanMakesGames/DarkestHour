//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DHVehicleFactory extends ROVehicleFactory
    abstract;

var() name FactoryDepletedEvent;

// Modified to trigger any FactoryDepletedEvent when last vehicle is spawned
// Also so factory is owner of spawned vehicle, allowing vehicle to access factory's properties during vehicle's initialization (allows use of leveller-specified properties in factory)
function SpawnVehicle()
{
    local ROLevelInfo ROL;
    local Pawn        P;
    local bool        bBlocked;

    ROL = ROTeamGame(Level.Game).LevelInfo;

    // Don't spawn this vehicle if there are too many already
    if (ROL != none && ROL.bUseVehicleTotalLimits && ROL.OverVehicleLimit(class<ROVehicle>(VehicleClass)))
    {
        bBlocked = true;
    }
    // Otherwise check if vehicle spawn is blocked by another pawn
    else
    {
        foreach CollidingActors(class'Pawn', P, VehicleClass.default.CollisionRadius * 1.25)
        {
            bBlocked = true;
            break;
        }
    }

    // If vehicle can't spawn, try again later
    if (bBlocked)
    {
        SetTimer(1.0, false);
    }
    // Otherwise spawn a vehicle
    else
    {
        if (bAllowOpposingForceCapture && TeamNum == AXIS)
        {
            LastSpawnedVehicle = Spawn(VehicleClass, self,, Location, Rotation + rot(0, 32768, 0));
        }
        else
        {
            LastSpawnedVehicle = Spawn(VehicleClass, self,, Location, Rotation);
        }

        if (LastSpawnedVehicle != none)
        {
            VehicleCount++;
            TotalSpawnedVehicles++;

            if (ROL != none)
            {
                ROL.HandleSpawnedVehicle(class<ROVehicle>(VehicleClass));
            }

            LastSpawnedTime = Level.TimeSeconds;
            LastSpawnedVehicle.SetTeamNum(TeamNum);
            LastSpawnedVehicle.ParentFactory = self;
            LastSpawnedVehicle.SetOwner(none); // reset (vehicle will have completed its own initialization by now)

            // Trigger any FactoryDepletedEvent if factory has reached its vehicle limit
            if (FactoryDepletedEvent != '' && TotalSpawnedVehicles >= VehicleRespawnLimit)
            {
                TriggerEvent(FactoryDepletedEvent, self, none);
            }
        }
        else
        {
            log("Spawned vehicle failed for" @ self);
        }
    }
}

// Matt: emptied out as we call StaticPrecache on the VehicleClass in PostBeginPlay(), so we don't want to do it twice
simulated function UpdatePrecacheMaterials()
{
}

defaultproperties
{
}
