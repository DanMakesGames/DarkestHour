//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_F1GrenadeWeapon extends DHExplosiveWeapon;

defaultproperties
{
    ItemName="F1 Grenade"
    FireModeClass(0)=class'DH_Weapons.DH_F1GrenadeFire'
    FireModeClass(1)=class'DH_Weapons.DH_F1GrenadeTossFire'
    AttachmentClass=class'DH_Weapons.DH_F1GrenadeAttachment'
    PickupClass=class'DH_Weapons.DH_F1GrenadePickup'

    Mesh=SkeletalMesh'Allies_F1nade_1st.F1-Grenade-Mesh'
    HighDetailOverlay=shader'Weapons1st_tex.Grenades.f1grenade_s'
    bUseHighDetailOverlayIndex=true
    HighDetailOverlayIndex=2

    FuzeLength=4.0
    bHasReleaseLever=true
    LeverReleaseSound=Sound'Inf_Weapons_Foley.F1.f1_handle'
    LeverReleaseVolume=1.0
    LeverReleaseRadius=200.0

    GroupOffset=0
}
