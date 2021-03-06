//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHSOVArtilleryOfficerRoles extends DHAlliedArtilleryOfficerRoles
    abstract;

defaultproperties
{
    AltName="Artillerie Ofitser"
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_PPSH41Weapon',AssociatedAttachment=class'ROInventory.ROPPSh41AmmoPouch')
    PrimaryWeapons(1)=(Item=class'DH_Weapons.DH_M38Weapon',AssociatedAttachment=class'ROInventory.ROMN9130AmmoPouch')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_TT33Weapon')
    Grenades(0)=(Item=class'DH_Equipment.DH_RDG1SmokeGrenadeWeapon')
    Grenades(1)=(Item=class'DH_Weapons.DH_F1GrenadeWeapon')
    GivenItems(0)="DH_Equipment.DHBinocularsItem"
    VoiceType="DH_SovietPlayers.DHSovietVoice"
    AltVoiceType="DH_SovietPlayers.DHSovietVoice"
    Headgear(0)=class'DH_SovietPlayers.DH_SovietOfficerHat'
}
