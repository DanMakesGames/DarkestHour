//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_Kar98Weapon extends DHBoltActionWeapon;

defaultproperties
{
    ItemName="Karabiner 98k"
    FireModeClass(0)=class'DH_Weapons.DH_Kar98Fire'
    FireModeClass(1)=class'DH_Weapons.DH_Kar98MeleeFire'
    AttachmentClass=class'DH_Weapons.DH_Kar98Attachment'
    PickupClass=class'DH_Weapons.DH_Kar98Pickup'

    Mesh=SkeletalMesh'DH_Kar98_1st.kar98k_mesh'
    HighDetailOverlay=shader'Weapons1st_tex.Rifles.k98_s'
    bUseHighDetailOverlayIndex=true
    HighDetailOverlayIndex=2

    IronSightDisplayFOV=25.0

    MaxNumPrimaryMags=13
    InitialNumPrimaryMags=13

    bHasBayonet=true
    BayonetBoneName="bayonet"
    BayoAttachAnim="Bayonet_on"
    BayoDetachAnim="Bayonet_off"
    IronBringUpRest="iron_inrest"
}
