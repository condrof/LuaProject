local ball={}
local ball_mt = { __index = ball } --meta table

--constructor
function ball.new(posx,posy)
	newBall = display.newImage ("ball.png", posx, posy)
	physics.addBody(newBall, "dynamic", {density = 1, friction = 0, bounce = .3, isSensor = false, radius = 12})
	newBall.isBullet = true
	
	return setmetatable(newBall, ball_mt)
end

-- Control motion with tilt

function ball:onAccelerate( event )
    physics.setGravity( 10 * event.xGravity, -10 * event.yGravity )
end

--return the object

return ball
