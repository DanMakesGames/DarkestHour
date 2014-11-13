//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_M1GarandPickup extends DHWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
/*  L.AddPrecacheStaticMesh(StaticMesh'DH_WeaponPickups.Weapons.M1_Garand');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.kar98pouch');
    L.AddPrecacheMaterial(Material'DH_Weapon_tex.AlliedSmallArms.m1garand');
    L.AddPrecacheMaterial(Material'DH_Weapon_tex.AlliedSmallArms.m1garandAmmo');
    L.AddPrecacheMaterial(Material'DH_Weapon_tex.AlliedSmallArms.m1garandBayo');
    L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.kar98_ammo'); */
}

defaultproperties
{
     TouchMessage="Pick Up: M1 Garand"
     MaxDesireability=0.780000
     InventoryType=Class'DH_Weapons.DH_M1GarandWeapon'
     PickupMessage="You got the M1 Garand."
     PickupForce="AssaultRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DH_WeaponPickups.Weapons.M1_Garand'
     PrePivot=(Z=3.000000)
     CollisionRadius=25.000000
     CollisionHeight=3.000000
}
