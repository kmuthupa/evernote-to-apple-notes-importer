(*
    Delete all of your Apple Notes notes
    Copyright (C) 2015  Lawrence A. Salibra, III

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
======	

Read https://www.larrysalibra.com/evernote-to-apple-notes/ and then
https://www.larrysalibra.com/can-apple-notes-replace-evernote/ *before* 
you run this. You have been warned.

======

This worked on Apple Notes Version 4.0 (535) on OS X 10.11 (15A284) 
It might not work on yours.

Known Issue: Deleted folders sometimes randomly reappear a short while later.
Workaround: Run the script again and/or manually delete the empty folders.

*)

tell application "Notes"
	display dialog "This script will delete all folders and notes from your Apple Notes iCloud account." & ¬
		linefeed & linefeed & "This action cannot be undone." buttons {"Cancel", "I'm sure! Let's do this! 💣"} ¬
		default button 1 with icon 2
	set thisAccountName to ¬
		(name of my getICloudAccount())
	repeat with theFolder in folders of account thisAccountName
		delete (every note of the theFolder)
	end repeat
	
	--Rumor has it deleting these built-in folders is bad.
	delete (every folder of account thisAccountName whose name is not "Notes" and name is not "All iCloud")
	display dialog "All folders and notes have been deleted from the account “" & ¬
		thisAccountName & ".”" buttons {"Great! 👍"} default button 1 with icon 1
end tell

on getICloudAccount()
	tell application "Notes"
		repeat with theAccount in every account
			if name of theAccount as string is equal to "iCloud" then
				return theAccount
			end if
		end repeat
		
		display dialog "I can't find your iCloud account! Perhaps your Apple Notes iCloud account isn't called iCloud or you've disabled it? I give up! 😧"
		error number -128
	end tell
end getICloudAccount