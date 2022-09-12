extends Control


func debugLog(text):
	if(OS.is_debug_build()):
		$dbgmsg.text=text
