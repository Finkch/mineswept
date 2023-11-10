--	play

function begin_game()
	init_grid(g.w,g.h)
	
	first=true
	second=false
	gameover=false
	win=false
	
	prev_mines=mines

	sfxflag=true
	
	tmr1=0
	tmr2=0
	tmr3=0
	tmrsecs=0
	
	fx=0
	fy=0
	
	fake_mines=0
	
	flags=0
	
	to_revl=g.w*g.h-mines
end



function play()
	
	sfxflag=true
	
	--	after the first reveal,
	--	place all of the mines
	if (first and btnx()) then
		first=false
		
		false_flag(c.tx,c.ty)
		
		place_mines(mines)
		place_numbers()
	end
	
	if (btnx() and is_tile(c.tx,c.ty,6)) cord(c.tx,c.ty)
	
	if (btnx() and not is_tile(c.tx,c.ty,6)) reveal(c.tx,c.ty)
	
	if (btno()) flag()


	if (to_revl<=0) then
		gameover=true
		win=true
	end

end


--	ensures the player loses on
--	the second move
function fake_play()
	
	--	second move logic
	if (second and btnx() and not is_tile(c.tx,c.ty,6) and not is_tile(c.tx,c.ty,5)) then
		
		fudge=0
		if (not is_tile(c.tx,c.ty,4)) fudge=1
		
		--	places a mine under the
		--	cursor
		mset(c.tx,c.ty,48)
		
		place_fake_mines(fake_mines)
		
		place_mines(mines-fake_mines-fudge)
		
		
		reveal(c.tx,c.ty)
		
	end
	
	
	--	first move logic
	if (first and btnx()) then
		
		fake_mines=rand_low(cnt_neighbours(c.tx,c.ty))
		
		mset(c.tx,c.ty,32+fake_mines)
		
		first=false
		second=true
		
		--	sets neighbours to a
		--	special flag
		false_flag(c.tx,c.ty)
		fx=c.tx
		fy=c.ty
	end

	
	--	can flag
	if (btno()) flag()
	
end


function rand_low(n)
	
	--	ensures number is less
	--	than mines
	local out=1000
	
	--	ensures that the correct
	--	number is returned if all
	--	mines are forced to be
	--	adjacent to first
	if ((g.w*g.h)-cnt_neighbours(c.tx,c.ty)<=1) return mines
	
	while (out>=mines) do
		out=n-flr(sqrt(rnd(n*n)))
	end

	--	uses the square root to
	--	make smaller numbers more
	--	likely
	return out
end


--	ensures that the right amount
--	of mines are placed around
--	the starting tile
function false_flag(x,y)
	
	--	prevents too many
	--	mines from being placed
	for dx=-1,1 do
		for dy=-1,1 do
			if (not (dx==0 and dy==0) and not oob(x+dx,y+dy)) mset(x+dx,y+dy,25)
		end
	end
	
end

function place_fake_mines(fakem)
	--	first counts neighbouring
	--	mines
	
	local fm=fakem
	
	for dx=-1,1 do
		for dy=-1,1 do
			if (is_tile(fx+dx,fy+dy,7)) fm-=1
		end
	end
	
	
	while (fm>0) do
		
		pos_x=flr(rnd(3))-1
		pos_y=flr(rnd(3))-1
		
		if (not (pos_x==0 and pos_y==0) and not is_tile(fx+pos_x,fy+pos_y,7) and not oob(fx+pos_x,fy+pos_y)) then 
			mset(fx+pos_x,fy+pos_y,26)
			fm-=1
		end
	
	end
	
end



function update_play()

		timer()
			
		update_cursor()
			
		if (not gameover) then
			if (fake) fake_play()
			
			if (not fake) play()
		
		end
		
		if (gameover) end_game()
		
end

function draw_play()
	camera()
	rectfill(2,18,125,125,6)
	
	
	--	absolute position draws
	camera(c.x-64,c.y-64)
	draw_grid()
	
	if (not gameover) draw_cursor()
	
	
	--	relative position draws
	camera()
	
end