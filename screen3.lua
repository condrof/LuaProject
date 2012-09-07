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

new = function ()

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
	local number = 0
	local w, h = display.contentWidth, display.contentHeight

	local topWall = display.newRect(0,0, w, 10)
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	local leftWall = display.newRect( 0, 0, 10, h )
	local rightWall = display.newRect( w - 10, 0, 10, h )	

	local ball = ballClass.new(display.contentWidth/2,display.contentHeight/2)


	r = display.newRect(100, 100, 50, 50 ) -- (left, top, width, height)
	r:setFillColor(0, 255, 0)
	r:setStrokeColor(255, 0, 0)

	------------------
	-- Physics
	------------------	

	physics.addBody(topWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})
	physics.addBody(bottomWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(leftWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(rightWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})	
	physics.addBody(ball, "dynamic", {density = 1, friction = 0, bounce = .3, isSensor = false, radius = 12})	
	physics.addBody( r, "static", { density=1.0, friction=10, bounce=0.2, shape=rectangleShape } )

	------------------
	-- Listeners
	------------------

	local touched = function ( event )
		director:changeScene("screen1", "moveFromRight")
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
		localGroup:insert( ball )
		localGroup:insert( r )

		------------------
		r:addEventListener( "touch" , touched )
		Runtime:addEventListener("accelerometer",function(event)
											  physics.setGravity( 10 * event.xGravity, -10 * event.yGravity )
											   end)			
		
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
