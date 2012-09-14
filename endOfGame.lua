module(..., package.seeall)

--====================================================================--
-- SCENE: [NAME]
--====================================================================--

--[[

 - Version: [1.0]
 - Made by: [name]
 - Website: [url]
 - Mail: [mail]

******************
 - INFORMATION
******************

  - [Your info here]

--]]

new = function ( params )
	
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Your code here
	------------------
	
	------------------
	-- Display Objects
	------------------	
	
	displayScore = display.newText(params.score,0,0,nil,30)
	displayScore.x = display.contentWidth/2
	displayScore.y = display.contentHeight/4
	
	restart = display.newText("Play Again",0,0,nil,30)
	restart:setTextColor(255,255,255)
	restart.x = display.contentWidth/2
	restart.y = 3*display.contentHeight/4
	
	------------------
	-- Listeners
	------------------

	local touched = function ( event )
		director:changeScene("screen1")
	end		
	
	local function initVars ()
	

		------------------
		-- Inserts
		------------------
	
		localGroup:insert( restart )
		localGroup:insert( displayScore )

		------------------
		-- Listeners
		------------------		
		restart:addEventListener("touch", touched)
		
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