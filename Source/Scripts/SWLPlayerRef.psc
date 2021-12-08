Scriptname SWLPlayerRef extends ReferenceAlias

Actor Property PlayerRef Auto
GlobalVariable Property SWLToggleLanternOn Auto

FormList Property SWLToggleLanterns Auto

Function Initialise()
  Armor lantern = GetEquippedLantern()
  If lantern
    PlayerRef.UnequipItem(lantern, abSilent = True)
    PlayerRef.EquipItem(lantern, abSilent = True)
  EndIf
EndFunction

Function Toggle()
  If GetEquippedLantern()
    bool value = SWLToggleLanternOn.GetValue() as bool
    value = !value
    SWLToggleLanternOn.SetValue(value as int)
  EndIf
EndFunction

Armor Function GetEquippedLantern()
  Int index = SWLToggleLanterns.GetSize()
  While index > 0
    index -= 1
    If PlayerRef.IsEquipped(SWLToggleLanterns.GetAt(index))
      Return SWLToggleLanterns.GetAt(index) as Armor
    EndIf
  EndWhile
EndFunction