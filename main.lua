-- animation tests
--libraries
require("player")

-----------------------------------------------------------
----MAIN GAME LOGIC
function love.load()
	love.window.setMode(600,400)
	love.graphics.setDefaultFilter("nearest","nearest")
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