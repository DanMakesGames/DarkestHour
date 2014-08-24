//=============================================================================
// G43Pickup
//=============================================================================
// G43 Weapon pickup
//=============================================================================
// Red Orchestra Source
// Copyright (C) 2005 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================

class DH_M1CarbinePickup extends ROWeaponPickup
   notplaceable;

//=============================================================================
// Functions
//=============================================================================

static function StaticPrecache(LevelInfo L)
{
/*  L.AddPrecacheStaticMesh(StaticMesh'DH_WeaponPickups.Weapons.M1_Carbine');
    L.AddPrecacheStaticMesh(StaticMesh'WeaponPickupSM.pouches.kar98pouch');
    L.AddPrecacheMaterial(Material'Weapons3rd_tex.German.g41_world');
    L.AddPrecacheMaterial(Material'Weapons1st_tex2.Rifles.G41_S');
    L.AddPrecacheMaterial(Material'Weapons1st_tex.Bullets.kar98k_stripper_s');
    L.AddPrecacheMaterial(Material'InterfaceArt_tex.HUD.kar98_ammo'); */
}

defaultproperties
{
     TouchMessage="Pick Up: M1 Carbine"
     MaxDesireability=0.780000
     InventoryType=Class'DH_Weapons.DH_M1CarbineWeapon'
     PickupMessage="You got the M1 Carbine."
     PickupForce="AssaultRiflePickup"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DH_WeaponPickups.Weapons.M1_Carbine'
     PrePivot=(Z=3.000000)
     CollisionRadius=25.000000
     CollisionHeight=3.000000
}
