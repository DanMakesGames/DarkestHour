//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_WSSSquadLeader extends DH_WaffenSS;

function class<ROHeadgear> GetHeadgear()
{
    if (FRand() < 0.2)
        return Headgear[0];
    else
        return Headgear[1];
}

defaultproperties
{
     bIsSquadLeader=true
     MyName="Squad Leader"
     AltName="Unterscharführer"
     Article="a "
     PluralName="Squad Leaders"
     InfoText="The squad leader is tasked with overseeing the completion of the squad's objectives by directing his men in combat and ensuring the overall firepower is put to good use.  With the effective use of smoke and close-quarters weaponry, the squad leader's presence is an excellent force multiplier to the units under his command."
     MenuImage=Texture'DHGermanCharactersTex.Icons.WSS_SqL'
     Models(0)="SS_1"
     Models(1)="SS_2"
     Models(2)="SS_3"
     Models(3)="SS_4"
     Models(4)="SS_5"
     Models(5)="SS_6"
     bIsLeader=true
     SleeveTexture=Texture'DHGermanCharactersTex.GerSleeves.Dot44Sleeve'
     PrimaryWeapons(0)=(Item=Class'DH_Weapons.DH_G43Weapon',Amount=9,AssociatedAttachment=Class'ROInventory.ROG43AmmoPouch')
     PrimaryWeapons(1)=(Item=Class'DH_Weapons.DH_MP40Weapon',Amount=6,AssociatedAttachment=Class'ROInventory.ROMP40AmmoPouch')
     SecondaryWeapons(0)=(Item=Class'DH_Weapons.DH_P38Weapon',Amount=1)
     SecondaryWeapons(1)=(Item=Class'DH_Weapons.DH_P08LugerWeapon',Amount=1)
     Grenades(0)=(Item=Class'DH_Weapons.DH_StielGranateWeapon',Amount=2)
     Grenades(1)=(Item=Class'DH_Equipment.DH_NebelGranate39Weapon',Amount=1)
     Grenades(2)=(Item=Class'DH_Equipment.DH_OrangeSmokeWeapon',Amount=1)
     Headgear(0)=Class'DH_GerPlayers.DH_SSCap'
     Headgear(1)=Class'DH_GerPlayers.DH_WSSCrushercap'
     PrimaryWeaponType=WT_SemiAuto
     bEnhancedAutomaticControl=true
     Limit=1
     Limit33to44=2
     LimitOver44=2
}
