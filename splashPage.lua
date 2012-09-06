module(..., package.seeall)

function splashPage()	--display a simple splash screen	
	name = display.newText("Fergal Condron",0,0,nil,30)
	name.x = display.contentWidth/2
	name.y = display.contentHeight/6
	
	stuNum = display.newText("D11127787",0,0,nil,30)
	stuNum.x = display.contentWidth/2
	stuNum.y = 2*display.contentHeight/6
	
	label = display.newText("Start Game", 0,0, nil, 30)
	label:setTextColor(255,255,255)

	label.x = display.contentWidth/2
	label.y = 5*display.contentHeight/6	

	label:addEventListener("tap", select.selectLevel)

end