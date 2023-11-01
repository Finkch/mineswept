--	grid


function init_grid(width, height)
	g={}
	
	g.w=width
	g.h=height
	
	
	--	resets the grid
	for i=0,max_dim-1 do
		for j=0,max_dim-1 do
			mset(i,j,0)
		end
	end
	
	
	--	fills the grid with non-
	--	mine tiles
	for i=0,g.w-1 do
		for j=0,g.h-1 do
			mset(i,j,16)
		end
	end
	
end


--	places the amount of mines
--	around the map
function place_mines(cnt)
	stuck=0
	
	
	--	randomly place the mines
	while (cnt > 0) do
		
		--	generates a random position
		pos_x = flr(rnd(g.w))
		pos_y = flr(rnd(g.h))
		
		
		--	checks if that spot is
		--	already a mine
		if (not is_tile(pos_x,pos_y,7) and not (pos_x == c.tx and pos_y == c.ty) and not is_tile(pos_x,pos_y,6) and (not is_tile(pos_x,pos_y,4) or stuck>=999)) then
			mset(pos_x,pos_y,48)
			cnt-=1
			stuck=0
		end
		
		stuck+=1
		
	end
end


--	sets the tile to represent
--	the number of adjacent
--	mines
function place_numbers()
	for i=0,g.w-1 do
		for j=0,g.h-1 do
			
			--	if the tile is not a mine,
			--	place a number
			if (not is_tile(i,j,7)) place_number(i,j)
			
		end
	end
end

--	counts number of mines in
--	adjacent tiles
function place_number(i,j)
	local cnt=0
	
	--	counts each neighbouring
	--	tile
	for di=-1,1 do
		for dj=-1,1 do
			
			if (is_tile(i+di,j+dj,7)) cnt+=1
			
		end
	end

	--	sets the sprite accordingly
	mset(i,j,16+cnt)

end


--	returns the binary count
--	of the tile's first four
--	flags; a number between
--	0 and 8
--	in other words, returns
--	the count of mines
-- surrounding the tile
function get_binary(x,y)
	local v=0
	
	if (is_tile(x,y,0)) v+=1
	if (is_tile(x,y,1)) v+=2
	if (is_tile(x,y,2)) v+=4
	if (is_tile(x,y,3)) v+=8
	
	return v
end



--	checks if a given tile is...
function is_tile(x,y,flag)
	return fget(mget(x,y),flag)
end



function draw_grid()
	
	--[[
	rectfill(-4,-4,g.w*8+3,g.h*8+3,6)
	line(-5,-5,g.w*8+4,-5,5)
	line(-5,-5,-5,g.h*8+4,5)
	
	line()
	line()
	--]]
	
	
	line(-1,-1,g.w*8-1,-1,7)
	line(-1,-1,-1,g.h*8,7)
	
	line(-1,g.h*8,g.w*8,g.h*8,5)
	line(g.w*8,-1,g.w*8,g.h*8,5)
	
	rectfill(0,0,g.w*8-1,g.h*8-1,0)
	
	map(0,0,0,0,128,64)
end



function neighbours(x,y,func)
	for dx=-1,1 do
		for dy=-1,1 do
			if (dx!=0 and dy!=0) func(x+dx,y+dy)
		end
	end
end

function oob(x,y)
	return (x<0 or x>g.w-1 or y<0 or y>g.h-1)
end 

function cnt_neighbours(x,y)
	local cnt=0
	
	for dx=-1,1 do
		for dy=-1,1 do
			if (not oob(x+dx,y+dy) and not (dx==0 and dy==0)) cnt+=1
		end
	end

	return cnt
end


function reveal_neighbours(x,y)
	for dx=-1,1 do
		for dy=-1,1 do
			reveal(x+dx,y+dy)
		end
	end
end