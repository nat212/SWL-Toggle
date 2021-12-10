Scriptname SWLToggleActiveEffect extends ActiveMagicEffect

TextureSet Property OnTextureSet Auto
TextureSet Property OffTextureSet Auto
Armor Property Lantern Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
  PO3_SKSEFunctions.ReplaceArmorTextureSet(akTarget, Lantern, OffTextureSet, OnTextureSet)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
  PO3_SKSEFunctions.ReplaceArmorTextureSet(akTarget, Lantern, OnTextureSet, OffTextureSet)
EndEvent