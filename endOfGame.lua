module(..., package.seeall)

function endOfGame()
	physics.stop()
	clrScreen()
	
	restart = display.newText("Play Again",0,0,nil,30)
	restart:setTextColor(255,255,255)
	restart.x = display.contentWidth/2
	restart.y = 3*display.contentHeight/4
	
	restart:addEventListener("tap",selectLevel)
end