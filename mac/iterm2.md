# iTerm2

iTerm2 is a better terminal app than the Mac's built in app.


## Meta

To make the Mac "option" key send "Meta" to terminals:

  * iTerm -> Preferences -> Profiles top tab -> Keys tab -> Left-option key acts as +Esc


## Term Tab Titles

http://superuser.com/questions/292652/change-iterm2-window-and-tab-titles-in-zsh

Deselect all the options for window and tab titles (one of the lines below should work)
	 
  * iTerm -> Preferences -> Appearance tab -> Window & Tab Titles area -> uncheck all

And in the .zshrc I have to uncomment/add export DISABLE_AUTO_TITLE="true" 


