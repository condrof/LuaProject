local ball={}
local ball_mt = { __index = ball } --meta table

--constructor
function ball.new(posx,posy)
	newBall = display.newImage ("ball.png", posx, posy)
	newBall.isVisible=true
	newBall.isActive=true
	newBall.filter = { categoryBits = 4, maskBits = 2 }
	--physics.addBody(newBall, "dynamic", {density = 1, friction = 0, bounce = .3, isSensor = false, radius = 12})
	newBall.isBullet = true
	
	return setmetatable(newBall, ball_mt)
end

function removepic()
	self.isVisible=false
end

-- Control motion with tilt

function ball:onAccelerate( event )
	if self.isActive then
		physics.setGravity( 10 * event.xGravity, -10 * event.yGravity )
	end
end

--control what happens in collision with hole
function ball:inHole(event)
if ( event.phase == "began" ) then
 
                print( "began: " .. event.object1.myName .. " & " .. event.object2.myName )
 
        elseif ( event.phase == "ended" ) then
 
                print( "ended: " .. event.object1.myName .. " & " .. event.object2.myName )
 
        end
end

--return the object

return ball
