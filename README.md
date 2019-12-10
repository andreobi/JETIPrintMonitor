# JETIPrintMonitor
Add some specific Print() statements in your code and and monitor the printed values in a Telemetry Window

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
