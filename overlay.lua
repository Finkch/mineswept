--	overlay

function draw_overlay()

	draw_header()
	
	draw_flag_box()
	
	draw_time_box()
	
	draw_background()
	
end

function draw_header()
	rectfill(0,0,128,14,6)
	
	line(1,1,126,1,5)
	line(1,1,1,13,5)
	
	line(1,13,126,13,7)
	line(126,1,126,13,7)
	
	line(1,1,126,1,5)
	line(1,1,1,13,5)
	
	line(2,13,126,13,7)
	line(126,1,126,13,7)
	

end

function draw_flag_box()
	
	box(23,3,37,11,0,false)
	print(format(mines-flags,3),25,5,8)

	box(41,3,49,11,6,true)
	spr(30,41,4)
end

function draw_time_box()
	
	box(125-35,3,125-21,11,0,false)
	print(format(flr(tmrsecs),3),125-33,5,8)

	box(125-48,3,125-39,11,6,true)	
	spr(31,125-47,4)
end


function draw_background()
	rectfill(0,14,128,16,6)
	line(0,14,0,128,6)
	line(0,127,127,127,6)
	line(127,14,127,127,6)
	
	line(1,17,126,17,5)
	line(1,17,1,126,5)
	
	line(2,126,126,126,7)
	line(126,17,126,126,7)
	
end



function format(num,digits)
	out=""..flr(num)
	
	while (#out < digits) do
		out="0"..out
	end
	
	return out
end


function box(x0,y0,x1,y1,bcol,inver)
	rectfill(x0,y0,x1,y1,bcol)
	
	c1=5
	c2=7
	
	if (inver) then
		c1=7
		c2=5
	end
	
	line(x0,y0,x1-1,y0,c1)
	line(x0,y0,x0,y1,c1)
	
	line(x0+1,y1,x1,y1,c2)
	line(x1,y0,x1,y1,c2)

end