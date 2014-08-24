//=============================================================================
// DH_RedSmokeDamType
//=============================================================================

class DH_RedSmokeDamType extends ROGrenadeDamType
    abstract;

//=============================================================================
// defaultproperties
//=============================================================================

defaultproperties
{
     HUDIcon=Texture'InterfaceArt_tex.deathicons.germgrenade'
     WeaponClass=Class'DH_Equipment.DH_RedSmokeWeapon'
     DeathString="%o was burned up by %k's M16 Red Smoke Grenade."
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
}
