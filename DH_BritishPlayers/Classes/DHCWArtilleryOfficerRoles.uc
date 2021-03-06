//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DHCWArtilleryOfficerRoles extends DHAlliedArtilleryOfficerRoles
    abstract;

defaultproperties
{
    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_EnfieldNo4Weapon')
    SecondaryWeapons(0)=(Item=class'DH_Weapons.DH_EnfieldNo2Weapon')
    GivenItems(0)="DH_Equipment.DHBinocularsItem"
    VoiceType="DH_BritishPlayers.DHBritishVoice"
    AltVoiceType="DH_BritishPlayers.DHBritishVoice"
    SleeveTexture=Texture'DHBritishCharactersTex.Sleeves.brit_sleeves'
}
