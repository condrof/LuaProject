module(..., package.seeall)

--====================================================================--
-- POP UP: SCREEN 3
--====================================================================--

--[[

 - Version: 1.3
 - Made by Ricardo Rauber Pereira @ 2010
 - Blog: http://rauberlabs.blogspot.com/
 - Mail: ricardorauber@gmail.com

******************
 - INFORMATION
******************

  - Sample scene.

--]]

new = function ( params )

	local physics = require("physics")
	physics.start()
	
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	
	local ballClass = require ("ball")
	local ball = {}
	local pocket = {}
	local size = params.level
	local w, h = display.contentWidth, display.contentHeight

	local topWall = display.newRect(0,0, w, 10)
	topWall.filter = { categoryBits = 10, maskBits = 10 }
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	bottomWall.filter = { categoryBits = 10, maskBits = 10 }
	local leftWall = display.newRect( 0, 0, 10, h )
	leftWall.filter = { categoryBits = 10, maskBits = 10 }
	local rightWall = display.newRect( w - 10, 0, 10, h )
	rightWall.filter = { categoryBits = 10, maskBits = 10 }

	local sensorRadius = 20	
	
	-- Add objects to use as collision sensors in the pockets

	for x=1,size,1 do 
		ball[x] = ballClass.new(math.random(20,display.contentWidth-20),math.random(30,display.contentHeight-20))
		--ball[x].filter = { categoryBits = 4, maskBits = 2 }
		localGroup:insert( ball[x] )

		physics.addBody(ball[x], "dynamic", {density = 1, friction = 0, bounce = .3, isSensor = false, radius = 12})	

	end
	------------------
	-- Physics
	------------------	

	physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})
	physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	

	------------------
	-- Listeners
	------------------

	local touched = function ( event )
		director:changeScene("endOfGame", "moveFromRight")
	end		


	function setPockets()
		local pocket = {}

		-- Add objects to use as collision sensors in the pockets
		local sensorRadius = 20
		pocket = display.newCircle( math.random(30,display.contentWidth-30), math.random(30,display.contentHeight-20), sensorRadius )
		localGroup:insert(pocket)

		-- (Change this value to "true" to make the pocket sensors visible)
		pocket.isVisible = true
		physics.addBody( pocket, "static", { radius=sensorRadius, isSensor=true } )
		pocket.id = "pocket"
		pocket.bullet = false
		pocket.collision = touched
		pocket:addEventListener( "collision", touched ) -- add table listener to each pocket sensor
		pocket:addEventListener("touch", touched)
	end
 	
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local function initVars ()
	
		------------------
		-- Inserts
		------------------
		
		localGroup:insert( topWall )
		localGroup:insert( bottomWall )
		localGroup:insert( leftWall )
		localGroup:insert( rightWall )

		------------------

		for x=1,size,1 do
			Runtime:addEventListener("accelerometer",function(event)
												ball[x]:onAccelerate( event )
											   end)	
											   
		--[[
		pocket[x]:addEventListener( "touch", function(event)
												if ( event.phase == "began" ) then
 
                print( "began: " .. event.object1.myName .. " & " .. event.object2.myName )
 
        elseif ( event.phase == "ended" ) then
 
                print( "ended: " .. event.object1.myName .. " & " .. event.object2.myName )
 
        end
											   end )  -- add table listener to each pocket sensor
		--]]
		--pocket[x]:addEventListener( "touch", touched ) -- add table listener to each pocket sensor											   
		end
		
		
	end


	------------------
	-- Initiate variables
	------------------
	
	initVars()
	setPockets()
	
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end
