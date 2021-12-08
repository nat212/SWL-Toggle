Scriptname SWLToggleMaintenance extends Quest

SWLPlayerRef Property SWLQuest Auto

Event OnInit()
  SWLQuest.Initialise()
EndEvent


Function Toggle()
  SWLQuest.Toggle()
EndFunction