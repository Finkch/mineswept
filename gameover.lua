--	gameover

function end_game()
	
	reveal_map()

	--	return to menu
	if (btno() and tmr1-tmr2>15) then
		_init()
	end
	
	--	new game, same settings
	if (btnx() and tmr1-tmr2>15) begin_game()
	
end


function reveal_map()
	--	reveals the map
	for i=0,g.w-1 do
	 for j=0,g.h-1 do
	 
	 	--	reveals mines
	 	if (is_tile(i,j,7) and not is_tile(i,j,5)) mset(i,j,50)
	 
	 	--	reveals false flags
	 	if (is_tile(i,j,5) and not is_tile(i,j,7)) mset(i,j,52)
	 
	 end
	end
	
end


function draw_end()

	box(3,126-30,124,122,0,true)

	if (not win) draw_gameover()
	
	if (win) draw_win()
	
	print("press ❎ to start a new game",8,126-19)
	print("press 🅾️ to return to menu",12,126-11)


end

function draw_gameover()
	print("you lose!", 46,126-27,8)
end

function draw_win()
	print("you win!", 46,126-27,8)
end