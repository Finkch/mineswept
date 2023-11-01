--	cursor

function init_cursor()
	c={}
	
	c.x=4
	c.y=4
	
	c.tx=0
	c.ty=0
	
end

function update_cursor()

	--	moves the cursor
	if (btn(➡️)) c.x+=1
	if (btn(⬅️)) c.x-=1
	
	if (btn(⬆️)) c.y-=1
	if (btn(⬇️)) c.y+=1
	
	
	--	locks cursor to play area
	if (c.x < 3) c.x=3
	if (c.x > g.w*8-4) c.x=g.w*8-4
	
	if (c.y < 3) c.y=3
	if (c.y > g.h*8-4) c.y=g.h*8-4
	
	--	gets the tile that the
	--	cursor is on
	c.tx=flr(c.x/8)
	c.ty=flr(c.y/8)
end


--	reveals the given tile
function reveal(x,y)
	
	-- does not reveal if tile is
	--	already revealed or is flag
	if (is_tile(x,y,6) or is_tile(x,y,5)) then
		
		if (sfxflag) sfx(0)
		
		return
	end
	
	--	does not reveal if tile is
	--	out of bounds
	if (oob(x,y)) return
	
	
	--	if mine
	if (is_tile(x,y,7)) then
		gameover=true
		sfx(1)
	else	--	not mine
		mset(x,y,16+mget(x,y))
		to_revl-=1
		
		if (get_binary(x,y)==0) then
			sfxflag=false
			reveal_neighbours(x,y)
		end
	end
	
end


-- if a revealed tile is
--	clicked and enough adjacent
--	tiles are flagged, then
--	reveal all neighbours
--	this is defined as chording
function cord(x,y)
	
	if (not is_tile(x,y,6)) return
	
	mine_tracker=get_binary(x,y)
	
	-- counts neighbours for flags
	--	and compares it to the
	--	current revealed tile
	
	adj_flags=0
	
	for dx=-1,1 do
		for dy=-1,1 do
			if (not oob(x+dx,y+dy) and not (dx==0 and dy==0) and is_tile(x+dx,y+dy,5)) adj_flags+=1
		end
	end

	
	--	if the counts match, then
	--	reveal all adjacent tiles
	if (mine_tracker==adj_flags) reveal_neighbours(x,y)
	
end



--	flags the given tile
function flag()
	
	--	returns if already revealed
	if (is_tile(c.tx,c.ty,6) or first) then
		sfx(0)
		return
	end
	
	--	if mine
	if (is_tile(c.tx,c.ty,7)) then
		
		--	if flag
		if (is_tile(c.tx,c.ty,5)) then
			mset(c.tx,c.ty,48)
			flags-=1
		else --	not flag
			--	returns if #mines would be
			--	less than zero
			if (mines-flags<=0) return
		
			mset(c.tx,c.ty,51)
			flags+=1
		end
		
	elseif (is_tile(c.tx,c.ty,4)) then	--	fake
	
		--	if flag
		if (is_tile(c.tx,c.ty,5)) then
			mset(c.tx,c.ty,25)
			flags-=1
		else --	not flag
		
			--	returns if #mines would be
			--	less than zero
			if (mines-flags<=0) return
		
			mset(c.tx,c.ty,41)
			flags+=1
		end
	
	else	--	not mine
	
		--	if flag
		if (is_tile(c.tx,c.ty,5)) then
			place_number(c.tx,c.ty)
			flags-=1
		else -- not flag
			--	returns if #mines would be
			--	less than zero
			if (mines-flags<=0) return
	
		
			mset(c.tx,c.ty,49)
			flags+=1
		end

	end
	
end


function draw_cursor()
	spr(3,c.x-3,c.y-3)
	
	--	draws the tile selection
	spr(54,c.tx*8,c.ty*8)
	
end