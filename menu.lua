--	menu


function init_menu()
	in_menu=true
	help_menu=false
	
	init_grid(g.w,g.h)
	
	min_mines=2
	max_mines=49
	
end


function update_menu()
	
	fake=true
	
	if (btn(🅾️)) fake=false
	
	
	--	begins game
	if (btnx()) then
		in_menu=false
		
		--	places the cursor in the
		--	middle of the screen
		c.x=g.w*4
		c.y=g.h*4
		
		begin_game()
	end
		
	
	--	moves menu cursor ⬆️ and ⬇️
	if (btnp(⬆️)) menu_pos-=1
	if (btnp(⬇️)) menu_pos+=1
	
	
	--	selects menu item
	if (menu_pos==0) then
		
		if (btnp(⬅️) and g.w>min_dim) then
			g.w-=1
			mines=flr(g.w*g.h/5)
		end
		
		if (btnp(➡️) and g.w<max_dim) then
			g.w+=1
			mines=flr(g.w*g.h/5)
		end
		
		if ((btnp(➡️) or btnp(⬅️)) and (g.w<=min_dim or g.w>=max_dim)) sfx(0)
		
	elseif (menu_pos==1) then
	
		if (btnp(⬅️) and g.h>min_dim) then
			g.h-=1
			mines=flr(g.w*g.h/5)
		end
		
		if (btnp(➡️) and g.h<max_dim) then
			g.h+=1
			mines=flr(g.w*g.h/5)
		end
		
		if ((btnp(➡️) or btnp(⬅️)) and (g.h<=min_dim or g.h>=max_dim)) sfx(0)
		
		
	else
		
		if (btnp(⬅️) and mines>min_mines) mines-=1
		
		if (btnp(➡️) and mines<max_mines) mines+=1		
		
		if ((btnp(➡️) or btnp(⬅️)) and (mines<=min_mines or mines>=max_mines)) sfx(0)
		
	end
	
	
	--	bounds menu cursor
	menu_pos%=menu_items
	
	
	--	bounds mines
	max_mines=mid(2,(g.w-1)*(g.h-1)-1,999)
	if (mines > max_mines) mines=max_mines

	if (mines < min_mines) mines=min_mines	
	
end


function draw_menu()

	print(menu_pos,8,32,8)
	print("width: "..g.w)
	print("height: "..g.h)
	print("mines: "..mines)
	
	draw_titlecard()
	
	draw_menu_items()
	
end

function draw_titlecard()
	
	rectfill(2,14,128-3,128-3,6)
	
	box(5,22,128-6,128-6,0,false)

	spr(64,14,34,13,2)
	
end

function draw_menu_items()

	spacing=16
	tall=8
	
	top=58

	draw_width()
	
	draw_height()
	
	draw_mines()
	
	draw_start_box()
end

function draw_width()
	box(64-7,top,64+7,top+tall,0,false)
	
	
	if (menu_pos==0) then
		print(format(g.w,3),64-5,top+2,8)
	
		spr(96,64-16,top+1,4,1)
		
		print(format(min_dim,1),64-21,top+2,5)
		print(format(max_dim,3),64+19,top+2,5)
		
		print("width",64-46,top+2,5)
	else
		print(format(g.w,3),64-5,top+2,5)
	end
end

function draw_height()
	box(64-7,top+spacing,64+7,top+spacing+tall,0,false)
	
	if (menu_pos==1) then
		print(format(g.h,3),64-5,top+spacing+2,8)
		
		spr(96,64-16,top+1+spacing,4,1)
		
		print(format(min_dim,1),64-21,top+2+spacing,5)
		print(format(max_dim,3),64+19,top+2+spacing,5)
	
		print("height",64-50,top+spacing+2,5)
	else
		print(format(g.h,3),64-5,top+spacing+2,5)
	end
end

function draw_mines()
	box(64-7,top+spacing*2,64+7,top+spacing*2+tall,0,false)

	if (menu_pos==2) then
		print(format(mines,3),64-5,top+spacing*2+2,8)
		
		spr(96,64-16,top+1+spacing*2,4,1)
	
		print(format(min_mines,1),64-21,top+2+spacing*2,5)
		print(format(max_mines,3),64+19,top+2+spacing*2,5)
	
		print("mines",64-46,top+spacing*2+2,5)
	else
		print(format(mines,3),64-5,top+spacing*2+2,5)
	end
end

function draw_start_box()
	box(64-35,top+spacing*3,64+35,top+spacing*3+tall,6,true)
	
	print("press ❎ to begin",64-33,top+spacing*3+2,5)
end