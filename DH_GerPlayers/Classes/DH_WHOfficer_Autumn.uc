//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2019
//==============================================================================

class DH_WHOfficer_Autumn extends DHGEArtilleryOfficerRoles;

defaultproperties
{
    RolePawns(0)=(PawnClass=class'DH_GerPlayers.DH_GermanParkaHeerPawn',Weight=2.0)
    RolePawns(1)=(PawnClass=class'DH_GerPlayers.DH_GermanSmockHeerPawn',Weight=1.0)
    SleeveTexture=Texture'DHGermanCharactersTex.GerSleeves.SplinterASleeve'
    Headgear(0)=class'DH_GerPlayers.DH_HeerHelmetCover'
    Headgear(1)=class'DH_GerPlayers.DH_HeerHelmetNoCover'

    PrimaryWeapons(0)=(Item=class'DH_Weapons.DH_Kar98Weapon',AssociatedAttachment=class'ROInventory.ROKar98AmmoPouch')
}
