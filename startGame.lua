module(..., package.seeall)
 
function startGame(level)
	clrScreen()	
	local ballClass = require ("ball")
	local wallClass = require("wall")
	local number = 0
	
-- create wall objects
--[[
	local topWall = wallClass.new(0,0, display.contentWidth, 10)
	local bottomWall = wallClass.new( 0, display.contentHeight - 10, display.contentWidth, 10 )
	local leftWall = wallClass.new( 0, 0, 10, display.contentHeight )
	local rightWall = wallClass.new( display.contentWidth - 10, 0, 10, display.contentHeight ) --]]
	
	wallClass.wallBorder()
	
	ball = {}
 
	if level=="easy" then
		for x=1,1,1 do
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	elseif level=="medium" then
		for x=1,2,1 do
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	else
		for x=1,3,1 do
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	end	

	r = display.newRect(100, 100, 50, 50 ) -- (left, top, width, height)
	r:setFillColor(0, 255, 0)
	r:setStrokeColor(255, 0, 0)
	physics.addBody( r, "static", { density=1.0, friction=10, bounce=0.2, shape=rectangleShape } )

end