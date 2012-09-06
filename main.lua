display.setStatusBar(display.HiddenStatusBar) --Hide the phones status bar
game = require("startGame")
splash = require("splashPage")
select = require("selectLevel")
endGame = require("endOfGame")

--start the physics engine and set the gravity
physics = require ("physics")
physics.start()
physics.setGravity(0,0)	--overhead view so no gravity

function clrScreen()
	--probably memory leakes re:EventListeners but the game is small enough that it doesn't matter
	local stage = display.getCurrentStage()	--get everything on the page
	while stage.numChildren > 0 do
		local obj = stage[1]
		obj:removeSelf()
		obj = nil
	end
end


splash.splashPage()
	