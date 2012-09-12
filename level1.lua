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

math.randomseed(os.time())

new = function ( params )

	local physics = require("physics")
	physics.start()
	physics.setGravity(0, 10)
	--physics.setDrawMode("debug")
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	local ball = {}
	local pocket = {}
	local size = params.level
	w, h = display.contentWidth, display.contentHeight
	local sensorRadius = 1
	local ballBounce = 0.3
	local countSeconds = 10
	
	local timeText = display.newText(countSeconds,0,0,nil,30)
	timeText.x = display.contentWidth - 20
	timeText.y = 25
	
	local timeDisplayText = display.newText("Time: ",0,0,nil,30)
	timeDisplayText.x = display.contentWidth - 80
	timeDisplayText.y = 25
	
	local topWall = display.newRect(0,50, w, 10)
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	local leftWall = display.newRect( 0, 50, 10, h )
	local rightWall = display.newRect( w - 10, 50, 10, h )	
	
	local leftSideWall1 = display.newRect(100,120,10,150)
	local leftSideWall2 = display.newRect(100,260,10,150)
	local rightSideWall1 = display.newRect(200,120,10,150)
	local rightSideWall2 = display.newRect(200,260,10,150)
	local topWall1 = display.newRect(100,120,40,10)
	local topWall2 = display.newRect(170,120,40,10)
	local bottomWall1 = display.newRect(100,410,40,10)
	local bottomWall2 = display.newRect(170,410,40,10)

	physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 0.3 })
	physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 0.3 })	
	physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 0.3 })	
	physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 0.3 })


	physics.addBody(leftSideWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(leftSideWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(rightSideWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(rightSideWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(topWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(topWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )
	physics.addBody(bottomWall1, "static", {density = 1.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(bottomWall2, "static", {density = 1.0, friction = 0, bounce = 0.3 } )		

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
	
	local win = function (event)
		local winCount=0
		for x=1,size,1 do
			if ball[x].active then
				winCount = winCount + 1
			end
		end
		if winCount == 0 then
			director:changeScene("endOfGame", "crossfade")		
		end
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
				win()
			--end
		end
	end
	
	--====================================================================--
	-- CREATE POCKETS
	--====================================================================--		

	function setPockets()
		local pocket = {}

		-- Add objects to use as collision sensors in the pockets
		for x=1,size,1 do 

			pocket[x] = display.newCircle( math.random(30,display.contentWidth-30), math.random(65,display.contentHeight-20), 15 )	
			localGroup:insert(pocket[x])
			physics.addBody( pocket[x], "static", { radius=sensorRadius, isSensor=true } )
			pocket[x].name = "pocket[" .. x .. "]"
			pocket[x].collision = onCollide
			pocket[x]:addEventListener( "collision", pocket[x] ) -- add table listener to each pocket sensor
		end
	end
	
	--====================================================================--
	-- TIMER
	--====================================================================--	
	
	local countTimer
	local function countDown ()
		 countSeconds = countSeconds - 1
		 timeText.text = countSeconds
		 if countSeconds == 0 then
			timer.cancel(countTimer)
			--director:changeScene("endOfGame", "crossfade")
		 end
	end
	countTimer = timer.performWithDelay(1000,  countDown, 0)
	
 	
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
		
		localGroup:insert(timeText)
		localGroup:insert(timeDisplayText)

	
		------------------
		-- CREATE BALLS
		------------------	
			
		for x=1,size,1 do 
			ball[x] = display.newImage ("ball.png", math.random(25,display.contentWidth-20),math.random(65,display.contentHeight-20))
			ball[x].filter = { categoryBits = 4, maskBits = 6 } 
			ball[x].name="ball["..x.."]"
			ball[x].active = true
			ball[x].isBullet = true

			physics.addBody(ball[x], "dynamic", {density = 1, friction = 0, bounce = ballBounce, radius = 12})	
			localGroup:insert( ball[x] )
		end
		
		for x=1,size,1 do
			Runtime:addEventListener("accelerometer", acceleration )
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
