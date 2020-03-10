HC = require "HC"

--world = HC.new(64)

objects = {}
crnt_id = 0

function objects:add_object(shape,info)
	crnt_id = crnt_id + 1
	
	--If new shape is rect info is x,y,w,h values
	if shape == "rect" then
		if #info == 4 then
			objects[crnt_id] = HC.rectangle(info[1], info[2],
											info[3], info[4])
		else
			add_object_ERROR(info)
			crnt_id = crnt_id -1 
		end
	--If new shape is a point info is x,y values
	else if shape == "point" then
		if #info == 2 then
			objects[crnt_id] = HC.point(info[1],info[2])
		else
			add_object_ERROR(shape, info, crnt_id)
			crnt_id = crnt_id -1
		end
	else 
		print("unrecognized shape of :"..shape)
	end

	
	return crnt_id
end

-- Used to output debug error messages
function add_object_ERROR(shape_in,info_in, crnt_id_in)
	print("Wrong number of values in info for new shape: "..shape_in..crnt_id_in)
	print("Info contained "..#info_in.." elements.")
	for i=1,#info_in do
		print(i..") info : "..info_in[i])
	end

end