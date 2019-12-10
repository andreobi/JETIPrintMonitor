--[[
The Print Montor is a development tool to visualise 4 values as a graph in a Telemetry window.
The values must be in a range from -1 to 1. There is no range check.
The graphical resolution is 50 dots high and <maxDot> dots on the timeline.
The timeline is shifted every loop and depense on the system loop time.
Only the last print sequence per loop will be displayed.
The displayed number is the <print(value)> multiplyed by 1000.
The red line has the lowest and the blackline the highest priority.
That means red will be overwritten by green and green by blue and all by black. 
To keep the program simple there is no color management.

Add the following code to your app you want to test:

print ("PM:")			-- signals the start sequence to the Print Monitor 
print (value_red)		-- print your variable here -1 to 1
print (value_green)		-- the values have to be a number type
print (value_blue)
print (value_black)

It is not recommended to run this program on a real device,
because it greps a lot of the device's recources.

Licence:

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

]]

local appName ="Print Monitor"
local maxDot=110
local color={{255,0,0},{0,255,0},{0,0,255},{0,0,0}}

local value={}
local printValue={}
local pValue=0

local org_Print=print

--------------------------------------------------------------------------------
print=function(...)
	local arg = {...}
	local line=arg[1]
	if type(line)=="string" and line:sub(1,3)=="PM:" then
		pValue=1
	elseif pValue>0 and pValue<5 and type(line)=="number" then
		printValue[pValue]=line*1000
		value[pValue][maxDot]=25-line*25
		pValue=pValue+1
	else
		pValue=0
		org_Print(...)
	end
end

--------------------------------------------------------------------------------
local function displayValues(width, height)
	for n=1,4,1 do
		lcd.setColor(color[n][1],color[n][2],color[n][3])
		local text=string.format("%5d",printValue[n])
		lcd.drawText(147-lcd.getTextWidth(FONT_NORMAL,text),(n-1)*16,text,FONT_NORMAL)
		local i=0
		local j
		repeat 
			j=i+1
			lcd.drawLine(i,value[n][i]+10,j,value[n][j]+10)
			value[n][i]=value[n][j]
			i=j
		until i>=maxDot
	end
end

--------------------------------------------------------------------------------
local function init()
	pValue=0
	for n=1,4,1 do
		value[n]={}
		printValue[n]=0
		for i=0,maxDot,1 do
			value[n][i]=25
		end
	end
	system.registerTelemetry(1,appName,2,displayValues)
end

--------------------------------------------------------------------------------
local function loop()
end

return {init=init, loop=loop, author="Andre", version="0.2", name=appName}
