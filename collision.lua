HC = require "HC"

--world = HC.new(64)

col_objects = {}
crnt_ID = 0

function col_objects:add_object(shape,info)
	crnt_ID = crnt_ID + 1
	
	--If new shape is rect info is x,y,w,h values
	if shape == "rect" then
		if #info == 4 then
			col_objects[crnt_ID] = HC.rectangle(info[1], info[2],
											info[3], info[4])
		else
			add_object_ERROR(info)
			crnt_ID = crnt_ID -1 
		end
	--If new shape is a point info is x,y values
	else if shape == "point" then
		if #info == 2 then
			col_objects[crnt_ID] = HC.point(info[1],info[2])
		else
			add_object_ERROR(shape, info, crnt_ID)
			crnt_ID = crnt_ID -1
		end
	else 
		print("unrecognized shape of :"..shape)
	end

	
	return crnt_ID
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
	local colisions_detected = HC.collisions(col_objects[object_ID])
	if #colisions_detected == 0 then
		return false 
	else
		return colisions_detected
	end
end



