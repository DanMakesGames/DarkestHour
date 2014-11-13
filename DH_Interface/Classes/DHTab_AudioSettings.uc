//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2014
//==============================================================================

class DHTab_AudioSettings extends ROTab_AudioSettings;

defaultproperties
{
     Begin Object Class=DHGUISectionBackground Name=AudioBK1
         Caption="Sound System"
         WinTop=0.100000
         WinLeft=0.000948
         WinWidth=0.485000
         WinHeight=0.700000
         OnPreDraw=AudioBK1.InternalPreDraw
     End Object
     i_BG1=DHGUISectionBackground'DH_Interface.DHTab_AudioSettings.AudioBK1'

     Begin Object Class=DHGUISectionBackground Name=AudioBK3
         Caption="Voice Chat"
         WinTop=0.100000
         WinLeft=0.495826
         WinWidth=0.502751
         WinHeight=0.633059
         OnPreDraw=AudioBK3.InternalPreDraw
     End Object
     i_BG3=DHGUISectionBackground'DH_Interface.DHTab_AudioSettings.AudioBK3'

     Begin Object Class=moSlider Name=AudioMusicVolume
         MaxValue=1.000000
         Caption="Music Volume"
         LabelStyleName="DHLargeText"
         OnCreateComponent=AudioMusicVolume.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.5"
         WinTop=0.070522
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=2
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     sl_MusicVol=moSlider'DH_Interface.DHTab_AudioSettings.AudioMusicVolume'

     Begin Object Class=moSlider Name=AudioEffectsVolumeSlider
         MaxValue=1.000000
         Caption="Effects Volume"
         LabelStyleName="DHLargeText"
         OnCreateComponent=AudioEffectsVolumeSlider.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="0.9"
         WinTop=0.070522
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=1
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     sl_EffectsVol=moSlider'DH_Interface.DHTab_AudioSettings.AudioEffectsVolumeSlider'

     Begin Object Class=moSlider Name=VoiceVolume
         MaxValue=10.000000
         MinValue=1.000000
         Caption="Voice Chat Volume"
         LabelStyleName="DHLargeText"
         OnCreateComponent=VoiceVolume.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.142484
         WinLeft=0.518507
         WinWidth=0.408907
         RenderWeight=1.040000
         TabOrder=3
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     sl_VOIP=moSlider'DH_Interface.DHTab_AudioSettings.VoiceVolume'

     Begin Object Class=DHmoComboBox Name=AudioMode
         bReadOnly=true
         Caption="Audio Mode"
         OnCreateComponent=AudioMode.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="Software 3D Audio"
         WinTop=0.149739
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=4
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     co_Mode=DHmoComboBox'DH_Interface.DHTab_AudioSettings.AudioMode'

     Begin Object Class=DHmoComboBox Name=AudioPlayVoices
         bReadOnly=true
         Caption="Play Voice Messages"
         OnCreateComponent=AudioPlayVoices.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="All"
         WinTop=0.149739
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=8
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     co_Voices=DHmoComboBox'DH_Interface.DHTab_AudioSettings.AudioPlayVoices'

     Begin Object Class=DHmoCheckBox Name=AudioReverseStereo
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Reverse Stereo"
         OnCreateComponent=AudioReverseStereo.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="false"
         WinTop=0.405678
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=7
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_ReverseStereo=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AudioReverseStereo'

     Begin Object Class=DHmoCheckBox Name=AudioMessageBeep
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Message Beep"
         OnCreateComponent=AudioMessageBeep.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="true"
         WinTop=0.405678
         WinLeft=0.524024
         WinWidth=0.450000
         TabOrder=9
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_MessageBeep=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AudioMessageBeep'

     Begin Object Class=DHmoCheckBox Name=DisableGameMusic
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Disable Music During Gameplay"
         OnCreateComponent=DisableGameMusic.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="false"
         WinTop=0.235052
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=10
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_DisableGameMusic=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.DisableGameMusic'

     Begin Object Class=DHmoCheckBox Name=AudioLowDetail
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="Low Sound Detail"
         OnCreateComponent=AudioLowDetail.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="false"
         WinTop=0.235052
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=5
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_LowDetail=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AudioLowDetail'

     Begin Object Class=DHmoCheckBox Name=AudioDefaultDriver
         ComponentJustification=TXTA_Left
         CaptionWidth=0.940000
         Caption="System Driver"
         OnCreateComponent=AudioDefaultDriver.InternalOnCreateComponent
         IniOption="@Internal"
         IniDefault="false"
         WinTop=0.320365
         WinLeft=0.018164
         WinWidth=0.450000
         TabOrder=6
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_Default=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AudioDefaultDriver'

     Begin Object Class=DHmoCheckBox Name=EnableVoiceChat
         CaptionWidth=-1.000000
         Caption="Enable Voice Chat"
         OnCreateComponent=EnableVoiceChat.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.834777
         WinLeft=0.527734
         WinWidth=0.461134
         TabOrder=20
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_VoiceChat=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.EnableVoiceChat'

     Begin Object Class=DHmoCheckBox Name=AutoJoinPublic
         CaptionWidth=0.940000
         Caption="Autojoin Public Channel"
         OnCreateComponent=AutoJoinPublic.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.145784
         WinLeft=0.086280
         WinWidth=0.826652
         TabOrder=23
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_AJPublic=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AutoJoinPublic'

     Begin Object Class=DHmoCheckBox Name=AutoSpeakCheckbox
         Caption="Auto-select Active Channel"
         OnCreateComponent=AutoSpeakCheckbox.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.603526
         WinLeft=0.039812
         WinWidth=0.442638
         WinHeight=0.060000
         TabOrder=24
         bBoundToParent=true
         bScaleToParent=true
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_AutoSpeak=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.AutoSpeakCheckbox'

     Begin Object Class=DHmoCheckBox Name=Dampen
         CaptionWidth=0.940000
         Caption="Dampen Game Volume When Using VOIP"
         OnCreateComponent=Dampen.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.145784
         WinLeft=0.086280
         WinWidth=0.826652
         TabOrder=21
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ch_Dampen=DHmoCheckBox'DH_Interface.DHTab_AudioSettings.Dampen'

     Begin Object Class=DHmoEditBox Name=DefaultActiveChannelEditBox
         CaptionWidth=0.600000
         Caption="Default Channel Name"
         OnCreateComponent=DefaultActiveChannelEditBox.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.757277
         WinLeft=0.032569
         WinWidth=0.420403
         TabOrder=25
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ed_Active=DHmoEditBox'DH_Interface.DHTab_AudioSettings.DefaultActiveChannelEditBox'

     Begin Object Class=DHmoEditBox Name=ChatPasswordEdit
         CaptionWidth=0.600000
         Caption="Chat Password"
         OnCreateComponent=ChatPasswordEdit.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.332828
         WinLeft=0.032569
         WinWidth=0.420403
         TabOrder=26
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     ed_ChatPassword=DHmoEditBox'DH_Interface.DHTab_AudioSettings.ChatPasswordEdit'

     Begin Object Class=DHmoComboBox Name=VoiceQuality
         bReadOnly=true
         CaptionWidth=0.600000
         Caption="Internet Quality"
         OnCreateComponent=VoiceQuality.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.241391
         WinLeft=0.523390
         WinWidth=0.408907
         TabOrder=27
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     co_Quality=DHmoComboBox'DH_Interface.DHTab_AudioSettings.VoiceQuality'

     Begin Object Class=DHmoComboBox Name=VoiceQualityLAN
         bReadOnly=true
         CaptionWidth=0.600000
         Caption="LAN Quality"
         OnCreateComponent=VoiceQualityLAN.InternalOnCreateComponent
         IniOption="@Internal"
         WinTop=0.333786
         WinLeft=0.523390
         WinWidth=0.408907
         TabOrder=28
         OnChange=DHTab_AudioSettings.InternalOnChange
         OnLoadINI=DHTab_AudioSettings.InternalOnLoadINI
     End Object
     co_LANQuality=DHmoComboBox'DH_Interface.DHTab_AudioSettings.VoiceQualityLAN'

}
