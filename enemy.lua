--enemies
anim8 = require "anim8"
vector = require "vector"
lume = require "lume"


enemy_db = {}
crnt_index = 0
enemy_anim_base = {}


Enemy = {

	type = nil,
	pos = vector(0,0),
	dir = vector(0,0),
	speed = 0

}

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

function Enemy:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

end

-- Used to 
function spawn_enemy(pos, type, speed)
	crnt_index = crnt_index + 1
	enemy_db[crnt_index] = Enemy:new({})

end


function update_enemies()
	for k,v in pairs
end


