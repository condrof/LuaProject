module(..., package.seeall)
 
function startGame(level)
	clrScreen()	
	local ballClass = require ("ball")
	local wallClass = require("wall")
	local number = 0
	
	wallClass.wallBorder()

	local pocket = {}
	-- Add objects to use as collision sensors in the pockets
	local sensorRadius = 20
	pocket = display.newCircle( math.random(0,display.contentWidth), math.random(0,display.contentHeight), sensorRadius )

	-- (Change this value to "true" to make the pocket sensors visible)
	pocket.isVisible = true
	physics.addBody( pocket, "static", { density=1.0, friction=10, radius=sensorRadius, isSensor=true } )
	pocket.id = "pocket"
	pocket.bullet = false
	pocket:addEventListener( "collision", endGame.endOfGame ) -- add table listener to each pocket sensor
	pocket:addEventListener( "tap", endGame.endOfGame ) -- add table listener to each pocket sensor

	
	ball = {}
 
	if level=="easy" then
		for x=1,1,1 do
			grade=1
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	elseif level=="medium" then
		for x=1,2,1 do
			grade=2
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	else
		for x=1,3,1 do
			grade=3
			ball[x] = ballClass.new(math.random(0,display.contentWidth),math.random(0,display.contentHeight))
			Runtime:addEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)
		end 
	end	
	
	local function endThisGame()
		--r:removeSelf()
		Runtime:removeEventListener( "collision", endGame.endOfGame ) -- add table listener to each pocket sensor
		for x=1,grade,1 do
			print(ball[x])
			Runtime:removeEventListener("accelerometer",function(event)
											  ball[x]:onAccelerate(event)
											   end)		
			ball[x] = nil
			table.remove(ball,x)
		end
		--endGame.endOfGame()
	end
	

	r = display.newRect(100, 100, 50, 50 ) -- (left, top, width, height)
	r:setFillColor(0, 255, 0)
	r:setStrokeColor(255, 0, 0)
	physics.addBody( r, "static", { density=1.0, friction=10, bounce=0.2, shape=rectangleShape } )
	
	r:addEventListener( "tap", endThisGame ) -- add table listener to each pocket sensor	

	
end