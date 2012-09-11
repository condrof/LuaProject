module(..., package.seeall)

--====================================================================--
-- SCENE: SCREEN 1
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
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
		
	local name = display.newText("Fergal Condron",0,0,nil,30)
	name.x = display.contentWidth/2
	name.y = display.contentHeight/6
	
	local stuNum = display.newText("D11127787",0,0,nil,30)
	stuNum.x = display.contentWidth/2
	stuNum.y = 2*display.contentHeight/6
	
	local label = display.newText("Start Game", 0,0, nil, 30)
	label:setTextColor(255,255,255)
	label.x = display.contentWidth/2
	label.y = 5*display.contentHeight/6	
	
	local touched = function ( event )
		director:changeScene("screen2", "crossfade")
	end
	
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local initVars = function ()
		
		------------------
		-- Inserts
		------------------
		
		localGroup:insert( name )
		localGroup:insert( stuNum )
		localGroup:insert( label )
		
		------------------
		-- Listeners
		------------------
		label:addEventListener( "touch" , touched )
		
		
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
