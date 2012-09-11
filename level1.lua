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
	physics.setGravity(0, 0)
	--physics.setDrawMode("debug")
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	--local wall = require("wall")
	local ball = {}
	local pocket = {}
	local size = params.level
	w, h = display.contentWidth, display.contentHeight
	local sensorRadius = 1
	local ballBounce = 0.3

	local topWall = display.newRect(0,0, w, 10)
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	local leftWall = display.newRect( 0, 0, 10, h )
	local rightWall = display.newRect( w - 10, 0, 10, h )	
	
	local leftSideWall1 = display.newRect(100,80,10,150)
	local leftSideWall2 = display.newRect(100,260,10,150)
	local rightSideWall1 = display.newRect(200,80,10,150)
	local rightSideWall2 = display.newRect(200,260,10,150)
	local topWall1 = display.newRect(100,80,40,10)
	local topWall2 = display.newRect(170,80,40,10)
	local bottomWall1 = display.newRect(100,410,40,10)
	local bottomWall2 = display.newRect(170,410,40,10)
	
	physics.addBody(leftSideWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(leftSideWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(rightSideWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(rightSideWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(topWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(topWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(bottomWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(bottomWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	
	physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})
	physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	
	--local border=wall.wallBorder()
	--local num=wall.number1()
	
	-- Add objects to use as collision sensors in the pockets


	------------------
	-- Listeners
	------------------
	
	local acceleration = function (event)
		physics.setGravity( 10 * event.xGravity, -10 * event.yGravity )				
	end
	
	local function inPocket(self,event)
		if event.phase == "began" then
			self.bodyType = "dynamic"
			self.active = true
			self:removeEventListener("collision", self)
		end
	end
	
	local function win (event)
		local count = 0
		for x=1,size,1 do
			if ball[x].active == false then
				count = count + 1
			end
		end
		if count == size then
			cleanUp()
		end
	end
	
	local function cleanUp(event)
		physics.stop()
		Runtime:removeEventListener("enterFrame", win )
		Runtime:removeEventListener("accelerometer", acceleration )
		director:changeScene("endOfGame", "crossfade")	
	end
	
	local function onCollide(self,event)
		if event.phase == "began" then
			x,y=event.other:getLinearVelocity()
			--if x < 200 and y < 200 then
				event.other.active = false
				event.other:setLinearVelocity(0,0)
				event.other.bodyType = "kinematic"
				event.other.collision = inPocket
				event.other:addEventListener("collision", event.other)
			--end
		end
	end

	function setPockets()
		local pocket = {}

		-- Add objects to use as collision sensors in the pockets
		for x=1,size,1 do 

			pocket[x] = display.newCircle( math.random(30,display.contentWidth-30), math.random(30,display.contentHeight-20), 15 )	
			localGroup:insert(pocket[x])
			physics.addBody( pocket[x], "static", { radius=sensorRadius, isSensor=true } )
			pocket[x].name = "pocket[" .. x .. "]"
			pocket[x].collision = onCollide
			pocket[x]:addEventListener( "collision", pocket[x] ) -- add table listener to each pocket sensor
		end
	end
	
 	
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local function initVars ()

		------------------
		-- Inserts
		------------------

		localGroup:insert(topWall)
		localGroup:insert(bottomWall)
		localGroup:insert(leftWall)
		localGroup:insert(rightWall)
		
		localGroup:insert(leftSideWall1)
		localGroup:insert(leftSideWall2)
		localGroup:insert(rightSideWall1)
		localGroup:insert(rightSideWall2)
		localGroup:insert(topWall1)
		localGroup:insert(topWall2)
		localGroup:insert(bottomWall1)
		localGroup:insert(bottomWall2)

	
		------------------
		-- Physics
		------------------	
			
		for x=1,size,1 do 
			ball[x] = display.newImage ("ball.png", math.random(20,display.contentWidth-20),math.random(30,display.contentHeight-20))
			ball[x].filter = { categoryBits = 4, maskBits = 6 } 
			ball[x].name="ball["..x.."]"
			ball[x].active = true

			physics.addBody(ball[x], "dynamic", {density = 1, friction = 0, bounce = ballBounce, isSensor = false, radius = 12})	
			localGroup:insert( ball[x] )
		end

			
		for x=1,size,1 do
			Runtime:addEventListener("accelerometer", acceleration )
		end		
		Runtime:addEventListener("enterFrame", win )
		Runtime:addEventListener("touch", cleanUp)
		
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
