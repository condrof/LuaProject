local wall={}
local wall_mt = { __index = wall } --meta table

--constructor
function wall.new(startx,starty,endx,endy)
	local newWall = display.newRect( startx, starty, endx, endy )

	-- make them physics bodies
	physics.addBody(newWall, "static", {density = 1.0, friction = 0, bounce = 0.3, isSensor = false})
	
	return setmetatable(newWall, ball_mt)
end

function wall:wallBorder()
	local topWall = wall.new(0,0, display.contentWidth, 10)
	local bottomWall = wall.new( 0, display.contentHeight - 10, display.contentWidth, 10 )
	local leftWall = wall.new( 0, 0, 10, display.contentHeight )
	local rightWall = wall.new( display.contentWidth - 10, 0, 10, display.contentHeight )
end

--return the object

return wall
