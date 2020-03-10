--enemies
anim8 = require "anim8"
vector = require "vector"
lume = require "lume"
require("config")
require("collision")


enemy_db = {}
crnt_index = 0
enemy_anim_base = {
		     bug_small =  {frames={col=4, row=2}, framerate=0.1,
	      				   w=12, h=12, on_loop=nil, 
	      			 	   image=nil, grid=nil, tot_time=nil}

}

-- Loads up the different animation sprite sheets and grids
function init_enemy_anims()
	for k,v in pairs(enemy_anim_base) do print(k) end

	for k,v in pairs(enemy_anim_base) do
		enemy_anim_base[k].image = love.graphics.newImage(k..".png")
		enemy_anim_base[k].grid = anim8.newGrid(enemy_anim_base[k].w, enemy_anim_base[k].h,
									 enemy_anim_base[k].image:getWidth(),
									 enemy_anim_base[k].image:getHeight())
	end
end



--[[
ONCE SPAWING IS IN PLACE THEN WORK HERE
-- Grid used to store large scale enemy pos to ease 
-- collision calculation over head
Grid = {
	width = nil, height = nil, size =nil	
}


function make_grid(screen_width_in, screen_height_in, increment)
	Grid.size = increment
	Grid.width = math.ceil(screen_width_inc/increment)
	Grid.height = math.ceil(screen_height_in/increment)
  
  	--intialize
	for x in range(Grid.width) do 
		table.insert(Grid, {})
		for y in range(Grid.height) do 
			table.insert(Grid[x], {})
		end
	end

end

function Grid:move_ID(new_index,old_index,ID_in)
	Grid[new_index][new_index]

end
]]


Enemy = {

	bug_type = nil,
	pos = vector(0,0),
	dir = vector(0,0),
	speed = 0

}

function Enemy:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
--After the instance of the enemy is created 
--This is used to intialize its values
function Enemy:intialize(type_in,pos,dir,speed)
	self.bug_type = type_in
	self.pos = pos
	self.dir = dir 
	self.speed = speed

	---Animation loader (see player class for indepth comments)
	local c_col = "1-"..enemy_anim_base[self.bug_type].frames.col
	local c_row = "1-"..enemy_anim_base[self.bug_type].frames.row
	local grid = enemy_anim_base[self.bug_type].grid(c_col, c_row)
	local framerate =  enemy_anim_base[self.bug_type].framerate
	local on_loop = enemy_anim_base[self.bug_type].on_loop
													 
	self.anim = anim8.newAnimation(grid, framerate, on_loop)
end


-- Used to load in new enemies to enemy_db
function spawn_enemy()--implement once done testing(random, pos, type, dir, speed)
	crnt_index = crnt_index + 1
	local pos = vector(lume.random(0, screen.size.w),
					   lume.random(0, screen.size.w))
	local dir = vector(0,0)
	local speed = 0

	
	enemy_db[crnt_index] = Enemy:new()
	print(enemy_db[crnt_index])
	enemy_db[crnt_index]:intialize("bug_small", pos, dir, speed)

end

-- used to update position movement and animations of all the enemies
function update_enemies(dt)
	for k,v in pairs(enemy_db) do
		enemy_db[k].anim:update(dt)
	end
end

function draw_enemies()
	for k,v in pairs(enemy_db) do
		local bug_type = enemy_db[k].bug_type
		enemy_db[k].anim:draw(enemy_anim_base[bug_type].image,
							 enemy_db[k].pos.x, enemy_db[k].pos.y)
	end
end


