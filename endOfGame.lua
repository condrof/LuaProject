module(..., package.seeall)

function endOfGame()
	clrScreen()
	
	endOfGame = display.newText("Your score was: " .. count, 0,0, nil, 30)	
	endOfGame:setTextColor(255,255,255)
	endOfGame.x = display.contentWidth/2
	endOfGame.y = display.contentHeight/4
	
	restart = display.newText("Play Again",0,0,nil,30)
	restart:setTextColor(255,255,255)
	restart.x = display.contentWidth/2
	restart.y = 3*display.contentHeight/4
	
	restart:addEventListener("tap",startGame)
end