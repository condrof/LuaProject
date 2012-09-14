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
	physics = require("physics")
	physics.start(true)
	physics.setGravity(0,0)
	--physics.setDrawMode("hybrid")
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	score = params.score
	local ball = {}
	local pocket = {}
	local size = params.level
	w, h = display.contentWidth, display.contentHeight
	local sensorRadius = 1
	local ballBounce = 0.3
	local countSeconds = 102
	
	local timeText = display.newText(countSeconds,0,0,nil,30)
	timeText.x = display.contentWidth - 20
	timeText.y = 25
	timeText.alpha = 0
	
	local timeDisplayText = display.newText("Time: ",0,0,nil,30)
	timeDisplayText.x = display.contentWidth - 80
	timeDisplayText.y = 25
	
	local displayScore = display.newText(score,0,0,nil,30)
	displayScore.x = 100
	displayScore.y = 25
	
	local topWall = display.newRect(0,50, w, 10)
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	local leftWall = display.newRect( 0, 50, 10, h )
	local rightWall = display.newRect( w - 10, 50, 10, h )	
	
	local leftSideWall1 = display.newRect(100,120,10,300)
	local rightSideWall1 = display.newRect(200,120,10,300)
	local topWall1 = display.newRect(100,120,40,10)
	local topWall2 = display.newRect(170,120,40,10)
	local bottomWall1 = display.newRect(100,410,40,10)
	local bottomWall2 = display.newRect(170,410,40,10)
	
	topWall.name = "Wall"
	topWall.alpha = 0
	bottomWall.name = "Wall"
	bottomWall.alpha = 0
	leftWall.name = "Wall"
	leftWall.alpha = 0
	rightWall.name = "Wall"
	rightWall.alpha = 0
	leftSideWall1.name = "Wall"
	leftSideWall1.alpha = 0
	rightSideWall1.name = "Wall"
	rightSideWall1.alpha = 0
	topWall1.name = "Wall"
	topWall1.alpha = 0
	topWall2.name = "Wall"
	topWall2.alpha = 0
	bottomWall1.name = "Wall"
	bottomWall1.alpha = 0
	bottomWall2.name = "Wall"
	bottomWall2.alpha = 0

	physics.addBody(topWall, "static", {density = 1000.0, friction = 0, bounce = 0.3 })
	physics.addBody(bottomWall, "static", {density = 1000.0, friction = 0, bounce = 0.3 })	
	physics.addBody(leftWall, "static", {density = 1000.0, friction = 0, bounce = 0.3 })	
	physics.addBody(rightWall, "static", {density = 1000.0, friction = 0, bounce = 0.3 })


	physics.addBody(leftSideWall1, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(rightSideWall1, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(topWall1, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )
	physics.addBody(topWall2, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )
	physics.addBody(bottomWall1, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )	
	physics.addBody(bottomWall2, "static", {density = 1000.0, friction = 0, bounce = 0.3 } )		

	------------------
	-- Listeners
	------------------
	
	local acceleration = function (event)
		physics.setGravity( 20 * event.xGravity, -20 * event.yGravity )				
	end
	
	local function inPocket(self,event)
		if event.other.name == "ball" then
			self.bodyType = "dynamic"
			self.active = true
			score = score - 1
			displayScore.text = score
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
			score = score + (countSeconds)
			params.score = score
			director:changeScene(params, "endOfGame", "crossfade")		
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
	
	local function checkSpawn(self,event)
		if (event.other.name == "Wall" or event.other.name == "Pocket" or event.other.name == "ball") and self.bodyType == "dynamic" then
			--print(self.id .. " in collision with " .. event.other.name .. " x: " .. self.x)
			local function doCollision()
				self.x = math.random(30,display.contentWidth-30) 
				self.y = math.random(65,display.contentHeight-20)
			end
			local collisionTimer = timer.performWithDelay( 1, doCollision, 1 )
		end
	end

	--====================================================================--
	-- TIMER
	--====================================================================--	
	
	local countTimer
	function countDown ()
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
		localGroup:insert(rightSideWall1)
		localGroup:insert(topWall1)
		localGroup:insert(topWall2)
		localGroup:insert(bottomWall1)
		localGroup:insert(bottomWall2)
		
		localGroup:insert(timeText)
		localGroup:insert(timeDisplayText)
		localGroup:insert(displayScore)

	
	--====================================================================--
	-- CREATE POCKETS
	--====================================================================--		
		
		local pocket = {}
		for x=1,size,1 do
			pocket[x]= display.newCircle( math.random(40,display.contentWidth-40), math.random(65,display.contentHeight-20), 15 )	
			pocket[x].name = "Pocket"
			pocket[x].id = "pocket[" .. x .. "]"
			pocket[x].alpha = 0
			pocket[x].collision = checkSpawn
			physics.addBody( pocket[x], "dynamic", { radius=sensorRadius, isSensor=true } )
			localGroup:insert(pocket[x])
			pocket[x]:addEventListener( "collision", pocket[x]) -- add table listener to each pocket	sensor
		end
		
		local function spawn(event)
			for x=1,size,1 do
				pocket[x].bodyType = "static"
				pocket[x].collision = onCollide
				transition.to(ball[x], {time = 500, alpha = 1 } )
				transition.to(pocket[x], {time = 500, alpha = 1 } )
				transition.to(topWall, {time = 500, alpha = 1 } )
				transition.to(bottomWall, {time = 500, alpha = 1 } )
				transition.to(leftWall, {time = 500, alpha = 1 } )
				transition.to(leftSideWall1, {time = 500, alpha = 1 } )
				transition.to(rightWall, {time = 500, alpha = 1 } )
				transition.to(rightSideWall1, {time = 500, alpha = 1 } )
				transition.to(topWall1, {time = 500, alpha = 1 } )
				transition.to(topWall2, {time = 500, alpha = 1 } )
				transition.to(bottomWall1, {time = 500, alpha = 1 } )
				transition.to(bottomWall2, {time = 500, alpha = 1 } )
				transition.to(timeText, {time = 500, alpha = 1 } )
			end
		end
	
		------------------
		-- CREATE BALLS
		------------------	
			
		for x=1,size,1 do 
			ball[x] = display.newImage ("ball.png", math.random(25,display.contentWidth-20),math.random(65,display.contentHeight-20))
			ball[x].filter = { categoryBits = 4, maskBits = 6 } 
			ball[x].name="ball"
			ball[x].alpha = 0
			ball[x].active = true
			ball[x].isBullet = true

			physics.addBody(ball[x], "dynamic", {density = 1, friction = 0, bounce = ballBounce, radius = 12})	
			localGroup:insert( ball[x] )
		end

		timer.performWithDelay(2000,spawn,1)
		
		for x=1,size,1 do
			Runtime:addEventListener("accelerometer", acceleration )
		end
	end


	------------------
	-- Initiate variables
	------------------
	
	initVars()
		
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end
