//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHWireCuttersItem extends DHWeapon;

var     float               CutDistance;
var     DHObstacleInstance  ObstacleBeingCut;

// Functions emptied out or returning false, as wire cutters aren't a real weapon
simulated function bool IsFiring(){return false;}
function bool FillAmmo(){return false;}
function bool ResupplyAmmo(){return false;}
simulated exec function ROManualReload() {return;}
simulated function bool IsBusy() {return false;}
simulated function bool ShouldUseFreeAim() {return false;}

// Modified to allow same InventoryGroup item (this shares same slot as shovel/satchel, each item on the slot requires multi-item support)
function bool HandlePickupQuery(Pickup Item)
{
    local int i;

    // If no passed item, prevent pick up & stops checking rest of Inventory chain
    if (Item == none)
    {
        return true;
    }

    // Pickup weapon is same as this weapon, so see if we can carry another
    if (Class == Item.InventoryType && WeaponPickup(Item) != none)
    {
        for (i = 0; i < NUM_FIRE_MODES; ++i)
        {
            if (AmmoClass[i] != none && AmmoCharge[i] < MaxAmmo(i) && WeaponPickup(Item).AmmoAmount[i] > 0)
            {
                AddAmmo(WeaponPickup(Item).AmmoAmount[i], i);

                // Need to do this here as we're going to prevent a new weapon pick up, so the pickup won't give a screen message or destroy/respawn itself
                Item.AnnouncePickup(Pawn(Owner));
                Item.SetRespawn();

                break;
            }
        }

        return true; // prevents pick up, as already have weapon, & stops checking rest of Inventory chain
    }

    // Didn't do any pick up for this weapon, so pass this query on to the next item in the Inventory chain
    // If we've reached the last Inventory item, returning false will allow pick up of the weapon
    return Inventory != none && Inventory.HandlePickupQuery(Item);
}

simulated state Cutting
{
    simulated function BeginState()
    {
        if (DHPawn(Instigator) != none)
        {
            DHPawn(Instigator).SetIsCuttingWire(true);
        }

        PlayAnim('cutStart');

        SetTimer(ObstacleBeingCut.Info.GetCutDuration(), false);
    }

    simulated function EndState()
    {
        local DHPawn P;

        P = DHPawn(Instigator);

        if (P != none)
        {
            P.SetIsCuttingWire(false);
        }
    }

    simulated function Tick(float DeltaTime)
    {
        super.Tick(DeltaTime);

        if (ObstacleBeingCut == none || ObstacleBeingCut.Info.IsCleared())
        {
            GotoState('');
            PlayAnim('cutEnd', 1.0, 0.2);
        }
    }

    simulated function Timer()
    {
        local DHPlayer P;

        if (Instigator != none)
        {
            P = DHPlayer(Instigator.Controller);
        }

        if (P != none)
        {
            P.ServerClearObstacle(ObstacleBeingCut.Info.Index);
        }

        GotoState('');
        PlayAnim('cutEnd', 1.0, 0.2);
    }

    simulated function AnimEnd(int Channel)
    {
        local name  SeqName;
        local float AnimRate, AnimFrame;

        GetAnimParams(Channel, SeqName, AnimFrame, AnimRate);

        super.AnimEnd(Channel);

        switch (SeqName)
        {
            case 'cutStart':
                PlayAnim('cutVin');
                break;
            case 'cutVin':
                PlayAnim('cutVout');
                break;
            case 'cutVout':
                PlayAnim('cutHin');
                break;
            case 'cutHin':
                PlayAnim('cutHout');
                break;
            case 'cutHout':
                PlayAnim('cutVin');
                break;
            default:
                break;
        }
    }

    simulated function bool WeaponCanSwitch()
    {
        return false;
    }

    simulated function bool WeaponAllowCrouchChange()
    {
        return false;
    }

    simulated function bool WeaponAllowProneChange()
    {
        return false;
    }
}

simulated function Fire(float F)
{
    local DHObstacleInstance O;
    local vector HitLocation, HitNormal, TraceEnd, TraceStart;

    if (Instigator == none ||
        Instigator.Controller == none ||
        Instigator.IsProneTransitioning() ||
        Instigator.Velocity != vect(0.0, 0.0, 0.0))
    {
        return;
    }

    TraceStart = Instigator.Location;
    TraceEnd = TraceStart + (vector(Instigator.Controller.Rotation) * CutDistance);

    foreach TraceActors(class'DHObstacleInstance', O, HitLocation, HitNormal, TraceEnd, TraceStart, vect(1.0, 1.0, 1.0))
    {
        if (O != none && !O.Info.IsCleared() && O.Info.CanBeCut())
        {
            ObstacleBeingCut = O;
            GotoState('Cutting');
            break;
        }
    }
}

defaultproperties
{
    ItemName="Wire Cutters"
    AttachmentClass=class'DHWireCuttersAttachment'
    InventoryGroup=7
    GroupOffset=2
    Priority=1
    bCanThrow=false
    CutDistance=100.0

    Mesh=SkeletalMesh'DH_Wirecutters_1st.wirecutters'

    DisplayFOV=70.0
    IronSightDisplayFOV=70.0
    PlayerFOVZoom=10.0
    bPlayerFOVZooms=true
    ZoomInTime=0.4
    ZoomOutTime=0.2
    bUsesFreeAim=false
    bCanSway=false

    SelectAnim="Draw" // TODO: rename anims to standard, inherited names & then delete these properties
    PutDownAnim="putaway"
    CrawlStartAnim="crawlIn"
    CrawlEndAnim="crawlOut"
    SprintStartAnim="sprintStart"
    SprintLoopAnim="sprintMiddle"
    SprintEndAnim="sprintEnd"

    AIRating=0.0
    CurrentRating=0.0
}
