#!/usr/bin/env lua

---Kill xscreensaver, cairo-compmgr and/or compton before running 
--mplayer and reactivate them after mplayer exits
-- @author Gianluca Fiore
-- @copyright 2011-2013, Gianluca Fiore <forod.g@gmail.com>
--

local cairo_pid = io.popen('ps -C cairo-compmgr -o pid='):read()
local compton_pid = io.popen('ps -C compton -o pid='):read()
local xscreensaver_pid = io.popen('ps -C xscreensaver -o pid='):read()
local xset_off = { 'os.execute(xset -dpms)', 'os.execute(xset s off)' }
local xset_on = { 'os.execute(xset +dpms)', 'os.execute(xset s on)' }

---Kill xscreensaver daemon if it's running
function kill_screensaver()
	local screen_pid = io.popen('ps -C xscreensaver -o pid='):read()
	if screen_pid then
		local screen = os.execute('kill -9 ' .. screen_pid)
	end
end

---Deactivate xscreensaver
function deactivate_screensaver()
	local cmd = 'xscreensaver-command -deactivate >&- 2>&- &'
	local screen = os.execute(cmd)
end

---Disable/Enable DPMS settings and screensaver
--@param t A table containing the xset commands to execute
function dpms(t)
	for _,c in pairs(t) do
		load(c)
	end
end

function main()
	if cairo_pid then
		local cairo = os.execute('kill -9 ' .. cairo_pid)
	end
	if xscreensaver_pid then
	--	kill_screensaver()
		deactivate_screensaver()
	end
	if compton_pid then
		local compton = os.execute('kill -9 ' .. compton_pid)
	end
	-- disable dpms and screensaver
	dpms(xset_off)
	local mp = os.execute('mplayer ' .. arg[1] .. ' > /dev/null 2>&1')
	local mplayer_pid = io.popen('ps -C mplayer -o pid=')
	-- re-enable dpms and screensaver
	dpms(xset_on)
end

main()

os.exit()
