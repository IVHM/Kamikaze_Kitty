HC = require "HC"

--world = HC.new(64)

col_objects = {}
crnt_ID = 0

function col_objects:add_object(shape,info)
	crnt_ID = crnt_ID + 1
	local ID_out
	
	--If new shape is rect info is x,y,w,h values
	if shape == "rect" then
		if #info == 4 then
			col_objects[crnt_ID] = HC.rectangle(info[1], info[2],
											    info[3], info[4])
			ID_out = crnt_ID
			print("rectangle add to world at x:"..info[1].." y:"..info[2])
		else
			add_object_ERROR(shape,info,crnt_ID)
			crnt_ID = crnt_ID -1
			ID_out = false 
		end

	--If new shape is a point info is x,y values
	elseif shape == "point" then
		if #info == 2 then
			col_objects[crnt_ID] = HC.point(info[1],info[2])
			ID_out = crnt_ID
		else
			add_object_ERROR(shape, info, crnt_ID)
			crnt_ID = crnt_ID -1
			ID_out = false
		end
	else 
		print("unrecognized shape of :"..shape)
	end

	
	return ID_out
end

-- Used to output debug error messages
function add_object_ERROR(shape_in,info_in, crnt_ID_in)
	print("Wrong number of values in info for new shape: "..shape_in..crnt_ID_in)
	print("Info contained "..#info_in.." elements.")
	for i=1,#info_in do
		print(i..") info : "..info_in[i])
	end

end

function col_objects:get_collisions(object_ID)
	local colisions_detected = HC.collisions(self[object_ID])
	if #colisions_detected == 0 then
		return false 
	else
		return colisions_detected
	end
end


function col_objects:move_object(ID_in, new_pos, new_rot)
		self[ID_in]:moveTo(new_pos.x, new_pos.y)

		if new_rot ~= nil then
			self[ID_in]:rotate(new_rot)
		end
end

function col_objects:get_neighbors(object_ID)
	local neighbors = HC.neighbors(self[object_ID])
	if #neighbors == 0 then
		return false
	else
		return neighbors
	end
end

function col_objects:draw_collision_shapes()
	love.graphics.setColor(0,0,255)
	for k,v in pairs(col_objects) do
		if type(k) == "number" then
			col_objects[k]:draw("line")
		end
	end
end