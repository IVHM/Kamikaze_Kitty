--Player "class"
anim8  = require "anim8"
vector = require "vector"
lume   = require "lume"
config = require "config"


-- MAIN PLAYER TABLE 
Player = {
	state = "walk",
	scale = 1,

	--MOVEMENT
	pos = vector(30,30),
	dir = vector(1, 1),
	speed = 200,

	--ATTACK
	can_attack = true,
	attack_rot = 0,
	attack_cooldown = .4,
	last_attack = love.timer.getTime(),

	-- Stores all the inforamtion and data for each animation
	-- Each animation's name is also its filename and table key
	-- The associated image is stored here, [[This mah change to a reference to a master sprite sheet]]
	anim_db = {
			   walk={frames={col=4, row=1}, framerate=0.1, 
					 w=20, h=20, on_loop=nil,
					 image=nil, grid=nil, tot_time=nil},
	    ---------------------------------------------------
	      explosion={frames={col=4, row=4}, framerate=0.08,
	      			 w=52, h=52, on_loop="pauseAtEnd", 
	      			 image=nil,grid=nil, tot_time=nil},
	    ---------------------------------------------------
	      	 attack={frames={col=2, row=3}, framerate=0.1,
	      			 w=44, h=44, on_loop="pauseAtEnd", 
	      			 image=nil, grid=nil, tot_time=nil}},
		---------------------------------------------------
	anim = {} --Stores the anim8 animtion instances of each different animation
}

function Player:loadAnimations()
	for k, v in pairs(self.anim_db) do
		--Calculate the time length of each animation
		local frm = self.anim_db[k].frames
		local frmrt = self.anim_db[k].framerate
		self.anim_db[k].tot_time = frm.col * frm.row * frmrt
		--Loads the spritesheet into love's working mem
		self.anim_db[k].image = love.graphics.newImage(k .. ".png")
		--Loads the atlas for the sprite sheet
		self.anim_db[k].grid = anim8.newGrid(v.w, v.h, 
									     	 self.anim_db[k].image:getWidth(),
									     	 self.anim_db[k].image:getHeight())
		--Creates a new animation
		local c_col = "1-"..self.anim_db[k].frames.col --create string range for sprite mapping		
		local c_row = "1-"..self.anim_db[k].frames.row
		print(k .. ": c_col:"..c_col..",  c_row:"..c_row)
		self.anim[k] = anim8.newAnimation(self.anim_db[k].grid(c_col,c_row),
										  self.anim_db[k].framerate, 
										  self.anim_db[k].on_loop)
	end

	self.anim["attack_r"] = self.anim["attack"]:clone():flipV()

end

--updates the curent frameset
function Player:step(dt)
	local crnt_time = love.timer.getTime()

	-- Check to see if the attack cooldown timer is done
	if not self.can_attack then
		if crnt_time - self.last_attack > self.attack_cooldown then
			self.can_attack = true
		end
	end

	self:input_check()
	self.pos = self.pos + (self.dir * self.speed * dt)


	self.anim[self.state]:update(dt)
	self.anim["attack"]:update(dt)
end

-- Handles all key board inputs realted to the player 
function Player:input_check()

	-- Movement input 
	local mov = vector(0,0)
	if love.keyboard.isDown('w') then mov.y = mov.y - 1 end
	if love.keyboard.isDown('a') then mov.x = mov.y - 1 end
	if love.keyboard.isDown('s') then mov.y = mov.y + 1 end
    if love.keyboard.isDown('d') then mov.x = mov.y + 1 end	
    mov:norm()
    Player.dir = mov:clone()

    --Attack input 
    if Player.can_attack then
	    mov.x, mov.y = 0, 0
		if love.keyboard.isDown('up')    then mov.y = mov.y - 1 end
		if love.keyboard.isDown('left')  then mov.x = mov.x - 1 end
		if love.keyboard.isDown('down')  then mov.y = mov.y + 1 end
	    if love.keyboard.isDown('right') then mov.x = mov.x + 1 end	
	    mov:norm()
	    if mov.x ~= 0 or mov.y ~= 0 then
			Player:fire(mov)	   
		end 
	end
end

--Handles all attack logic
function Player:fire(vec_in)
   	self.last_attack = love.timer.getTime() -- start the attack delay timer
   	self.can_attack = false                  
	self.attack_rot = lume.round(-vec_in:heading(),.001)  --this value needs to be inverted...for some reason....
	print(self.attack_rot)

	if self.attack_rot == 45 then
		self.anim["attack_r"]:gotoFrame(1)
		self.anim["attack_r"]:resume()
	else
		--resets the animation to the begining and plays it
		self.anim["attack"]:gotoFrame(1)
		self.anim["attack"]:resume()
	end
end

--Outputs the animation to the screen, good luck and read the docs
function Player:show()
	self.anim[self.state]:draw(self.anim_db[self.state].image,
							   Player.pos.x, Player.pos.y, 
							   Player.rot, Player.scale, Player.scale,
							   8, 12)
	local flip_v = 1
	if self.attack_rot == 0 or math.abs(self.attack_rot) == 0.785 then
		flip_v = -1
	end
	self.anim["attack"]:draw(self.anim_db["attack"].image,
							 Player.pos.x, Player.pos.y,
							 self.attack_rot
							 , Player.scale, flip_v * Player.scale
							 ,22,22)

end

