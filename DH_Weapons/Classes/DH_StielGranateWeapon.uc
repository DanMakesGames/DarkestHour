//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_StielGranateWeapon extends DHExplosiveWeapon;

defaultproperties
{
    ItemName="Stielhandgranate 39/43"
    FireModeClass(0)=class'DH_Weapons.DH_StielGranateFire'
    FireModeClass(1)=class'DH_Weapons.DH_StielGranateTossFire'
    AttachmentClass=class'DH_Weapons.DH_StielGranateAttachment'
    PickupClass=class'DH_Weapons.DH_StielGranatePickup'

    DisplayFOV=70.0
    Mesh=SkeletalMesh'Axis_Granate_1st.German-Grenade-Mesh'
    HighDetailOverlay=shader'Weapons1st_tex.Grenades.stiel_s'
    bUseHighDetailOverlayIndex=true
    HighDetailOverlayIndex=2

    GroupOffset=3
}
