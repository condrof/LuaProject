module(..., package.seeall)

function wallBorder()
	local topWall = display.newRect(0,0, w, 10)
	local bottomWall = display.newRect( 0, h - 10, w, 10 )
	local leftWall = display.newRect( 0, 0, 10, h )
	local rightWall = display.newRect( w - 10, 0, 10, h )	
end
