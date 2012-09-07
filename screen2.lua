module(..., package.seeall)

--====================================================================--
-- SCENE: SCREEN 2
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

	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	
	local easy = display.newText("Easy",0,0,nil,30)
	easy.x = display.contentWidth/2
	easy.y = display.contentHeight/6
	
	local medium = display.newText("Medium",0,0,nil,30)
	medium.x = display.contentWidth/2
	medium.y = 2*display.contentHeight/6

	local hard = display.newText("Hard",0,0,nil,30)
	hard.x = display.contentWidth/2
	hard.y = 3*display.contentHeight/6
	
	------------------
	-- Listeners
	------------------
	
	local touched = function ( event )
		director:changeScene("screen3", "moveFromRight")
	end
		
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local initVars = function ()
		
		------------------
		-- Inserts
		------------------
		
		localGroup:insert( easy )
		localGroup:insert( medium )
		localGroup:insert( hard )

	
		------------------
		-- Listeners
		------------------
		
		easy:addEventListener( "touch" , touched )

				
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
