tell application "System Events"
	set {processList, pidList} to the {name, unix id} of (every process whose name is equal to "Spotify")

	if (count of pidList) is not equal to 1 then return

	-- Find any mp3 open by the Spotify process
	set comm to "lsof -p " & pidList & " -F | grep -i '.mp3' | sed s/^n//g | tr -d '\n'"
	set file_name to do shell script comm

	-- Prompt user to delete it
	display dialog "Really delete " & file_name buttons {"Yes", "No"}

	if button returned of result is equal to "Yes" then
		-- Skip track and delete file
		tell application "Spotify"
			play (next track)
		end tell

		do shell script "rm \"" & file_name & "\""
	end if
end tell
