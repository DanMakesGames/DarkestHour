//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DH_American_Units extends DH_RoleInfo
    abstract;

defaultproperties
{
     VoiceType="DH_USPlayers.DHUSVoice"
     AltVoiceType="DH_USPlayers.DHUSVoice"
     DetachedArmClass=Class'ROEffects.SeveredArmSovTunic'
     DetachedLegClass=Class'ROEffects.SeveredLegSovTunic'
     RolePawnClass="DH_USPlayers.DH_AmericanPawn"
     Side=SIDE_Allies
}
