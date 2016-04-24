//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2015
//==============================================================================

class DHColor extends Object
    abstract;

var color TeamColors[2];
var color SquadColor;
var color InputPromptColor;

defaultproperties
{
    TeamColors(0)=(R=200,G=72,B=72,A=255)       // Crimson
    TeamColors(1)=(R=151,G=154,B=223,A=255)     // Light Blue
    SquadColor=(R=124,G=252,B=0,A=255)          // Green
    InputPromptColor=(R=255,G=255,B=0,A=255)    // Yellow
}
