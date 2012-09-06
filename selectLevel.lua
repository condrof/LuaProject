module(..., package.seeall)

function selectLevel()
	clrScreen()

	easy = display.newText("Easy",0,0,nil,30)
	easy.x = display.contentWidth/2
	easy.y = display.contentHeight/6
	
	medium = display.newText("Medium",0,0,nil,30)
	medium.x = display.contentWidth/2
	medium.y = 2*display.contentHeight/6

	hard = display.newText("Hard",0,0,nil,30)
	hard.x = display.contentWidth/2
	hard.y = 3*display.contentHeight/6
	
	local function easyLevel()	--i don't like corona
		game.startGame("easy")
	end
	local function mediumLevel()
		game.startGame("medium")
	end
	local function hardLevel()
		game.startGame("hard")
	end
	
	easy:addEventListener("tap",easyLevel) 
	medium:addEventListener("tap", mediumLevel)
	hard:addEventListener("tap", hardLevel)
end