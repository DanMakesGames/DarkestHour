//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_SSHelmetCover extends DH_Headgear;

static function StaticPrecache(LevelInfo L)
{
//  L.AddPrecacheMaterial(Material'GermanCharactersTex.WSS.WSSParkaCam1');
}

defaultproperties
{
     Mesh=SkeletalMesh'dhgear_anm.Ger_HelmetCover'
     Skins(0)=Texture'DHGermanCharactersTex.WSS.WSSParkaCam1'
}
