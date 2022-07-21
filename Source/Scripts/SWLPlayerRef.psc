Scriptname SWLPlayerRef extends ReferenceAlias

Actor Property PlayerRef Auto
GlobalVariable Property SWLToggleLanternOn Auto

FormList Property SWLToggleLanterns Auto
FormList Property SWLToggleTextureSetsOn Auto
FormList Property SWLToggleTextureSetsOff Auto

Int Property MajorVersion = 0 Auto Hidden
Int Property MinorVersion = 0 Auto Hidden
Int Property PatchVersion = 0 Auto Hidden

Function Maintenance()
  Int currentMajor = 1
  Int currentMinor = 2
  Int currentPatch = 0
  Int installedVersion = (MajorVersion * 100) + (MinorVersion * 10) + PatchVersion
  Int currentVersion = (currentMajor * 100) + (currentMinor * 10) + currentPatch
  If installedVersion < currentVersion
    ReEquipLanterns()
    MajorVersion = currentMajor
    MinorVersion = currentMinor
    PatchVersion = currentPatch
  EndIf
EndFunction

Function ReEquipLanterns()
  Armor lantern = GetEquippedLantern()
  If lantern
    PlayerRef.UnequipItem(lantern, abSilent = True)
    PlayerRef.EquipItem(lantern, abSilent = True)
  EndIf
EndFunction

Function Toggle()
  Armor lantern = GetEquippedLantern()
  If lantern
    bool value = SWLToggleLanternOn.GetValue() as bool
    value = !value
    SWLToggleLanternOn.SetValue(value as int)
  EndIf
EndFunction

Int Function GetEquippedLanternIndex()
  Armor lantern = GetEquippedLantern()
  Int index = SWLToggleLanterns.GetSize()
  While index > 0
    index -= 1
    If SWLToggleLanterns.GetAt(index).GetFormID() == lantern.GetFormID()
      Return index
    EndIf
  EndWhile
EndFunction

Armor Function GetEquippedLantern()
  Int slotMask = Armor.GetMaskForSlot(49);
  Form lantern = PlayerRef.GetWornForm(slotMask)
  If lantern
    Int index = SWLToggleLanterns.GetSize()
    While index > 0
      index -= 1
      Form l = SWLToggleLanterns.GetAt(index)
      If l.GetFormID() == lantern.GetFormID()
        return lantern as Armor
      EndIf
    EndWhile
  EndIf
EndFunction

Event OnPlayerLoadGame()
  Maintenance()
  Armor lantern = GetEquippedLantern()
  If lantern && !SWLToggleLanternOn.GetValue()
    Int index = GetEquippedLanternIndex()
    PO3_SKSEFunctions.ReplaceArmorTextureSet(PlayerRef, lantern, SWLToggleTextureSetsOn.GetAt(index) as TextureSet, SWLToggleTextureSetsOff.GetAt(index) as TextureSet)
  EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
  If SWLToggleLanternOn.GetValue()
    Return
  EndIf
  Int i = SWLToggleLanterns.GetSize()
  While i > 0
    i -= 1
    Form l = SWLToggleLanterns.GetAt(i)
    If l.GetFormID() == akBaseObject.GetFormID()
      PO3_SKSEFunctions.ReplaceArmorTextureSet(PlayerRef, l as Armor, SWLToggleTextureSetsOn.GetAt(i) as TextureSet, SWLToggleTextureSetsOff.GetAt(i) as TextureSet)
      Return
    EndIf
  EndWhile
EndEvent