-- animation tests
--libraries
require("player")
conifg require "config"
-----------------------------------------------------------
----MAIN GAME LOGIC
function love.load()
	love.window.setMode(config.screen.size.w,config.screen.size.h)
	love.graphics.setDefaultFilter(config.screen.filter)
	Player:loadAnimations()
end

----MAIN GAME LOOP
function love.update(dt)
	Player:step(dt)
end



function love.draw()
	love.graphics.setColor(100,120,110)
	love.graphics.rectangle("fill",0,0,600,400)
	Player:show()
end