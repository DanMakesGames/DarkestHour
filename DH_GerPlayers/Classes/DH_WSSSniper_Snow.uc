// *************************************************************************
//
//  ***  SS Sniper ***
//
// *************************************************************************


class DH_WSSSniper_Snow extends DH_WaffenSSSnow;

defaultproperties
{
     MyName="Sniper"
     AltName="Scharfschütze"
     Article="a "
     PluralName="Snipers"
     InfoText="The sniper is tasked with the specialized goal of eliminating key hostile units and shaking enemy morale through careful marksmanship and fieldcraft.  Through patient observation, the sniper is also capable of providing valuable reconnaissance which can have a significant impact on the outcome of the battle."
     menuImage=Texture'DHGermanCharactersTex.Icons.WSS_Sniper'
     Models(0)="SSS_1"
     Models(1)="SSS_2"
     Models(2)="SSS_3"
     Models(3)="SSS_4"
     Models(4)="SSS_5"
     Models(5)="SSS_6"
     SleeveTexture=Texture'Weapons1st_tex.Arms.RussianSnow_Sleeves'
     PrimaryWeapons(0)=(Item=Class'DH_Weapons.DH_Kar98ScopedWeapon',Amount=18,AssociatedAttachment=Class'ROInventory.ROKar98AmmoPouch')
     PrimaryWeapons(1)=(Item=Class'DH_Weapons.DH_G43ScopedWeapon',Amount=6)
     SecondaryWeapons(0)=(Item=Class'DH_Weapons.DH_P38Weapon',Amount=1)
     SecondaryWeapons(1)=(Item=Class'DH_Weapons.DH_P08LugerWeapon',Amount=1)
     Headgear(0)=Class'DH_GerPlayers.DH_SSHelmetSnow'
     PrimaryWeaponType=WT_Sniper
     limit=2
}
