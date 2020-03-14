-- animation tests
--libraries
require("player")
require("enemy")
require("config")
require("collision")


-----------------------------------------------------------
----MAIN GAME LOGIC
function love.load()
	love.window.setMode(screen.size.w, screen.size.h)
	love.graphics.setDefaultFilter(screen.filter)
	Player:loadAnimations()
	Player:col_init()

	init_enemy_anims()

	for i=0,10 do
		spawn_enemy()
	end
end

----MAIN GAME LOOP
function love.update(dt)
	Player:step(dt)
	update_enemies(dt)
end



function love.draw()
	love.graphics.setColor(100,120,110)
	love.graphics.rectangle("fill",0,0,600,400)
	Player:show()
	draw_enemies()
end