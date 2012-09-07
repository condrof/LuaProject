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
	
	local params = {
		level=1
	}
	
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
	
	local easyTouched = function ( event )
		params.level = 1
		director:changeScene(params, "screen3", "moveFromRight")
	end
	
	local medTouched = function ( event )
		params.level = 2
		director:changeScene(params, "screen3", "moveFromRight")
	end
	
	local hardTouched = function ( event )
		params.level = 4
		director:changeScene(params, "screen3", "moveFromRight")
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
		
		easy:addEventListener( "touch" , easyTouched )
		medium:addEventListener( "touch" , medTouched )
		hard:addEventListener( "touch" , hardTouched )

				
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
