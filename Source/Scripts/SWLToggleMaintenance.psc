Scriptname SWLToggleMaintenance extends Quest

SWLPlayerRef Property SWLQuest Auto

Event OnInit()
  SWLQuest.Maintenance()
EndEvent


Function Toggle()
  SWLQuest.Toggle()
EndFunction