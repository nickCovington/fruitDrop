basket_sprite = 1

player_sprite = 2
player_x = 64
player_y = 104

-- fruits will be stored in an array, and continuously selected at random
fruits = {}
fruit_start = 16
fruit_count = 5
fruit_interval = 16

gravity = 1

level = 1
points = 0

function _init()
    --adds a random assortment of fruit sprites into our array
	for i=1, level do
		fruit = {
			sprite = flr(rnd(fruit_count) + fruit_start), 
			x= flr(rnd(120) + 5),
			y= i * (-fruit_interval)
		}
		add(fruits, fruit)
	end
end

function _update()
    --moves player left, and ensures he doesn't go offscreen
	if (btn(0)) then
		if (player_x > 4) then
			player_x -= 3
			alternate_sprite()
		end
	end
    
    --moves player right, and ensures he doesn't go offscreen
	if (btn(1)) then
		if (player_x < 123) then
			player_x += 3
			alternate_sprite()
		end
	end
    
    --make the fruits fall
	for fruit in all(fruits) do
		fruit.y += gravity
		
		-- catch fruit in basket
		if fruit.y +4 > player_y -8
		and fruit.y +4 < player_y
		and fruit.x +4 > player_x
		and fruit.x +4 < player_x +8 then
			points += 1
			del(fruits, fruit)
			sfx(0)
		end
		
		-- fruit splats on ground
		if fruit.y > 100 then
			del(fruits, fruit)
			sfx(1)
		end
	end
    
    --if all fruits have descended, advance player to next level
	if #fruits == 0 then
		level += 1
		_init()
	end
	
end

function _draw()
	cls()
	map(0, 0, 0, 0, 127, 127)
	spr(player_sprite, player_x, player_y)
	spr(basket_sprite, player_x, player_y - 8)

	for fruit in all(fruits) do
		spr(fruit.sprite, fruit.x, fruit.y)
	end
	
	print("collected: "..points, 0, 0, 10)
end

--player's walking animation
function alternate_sprite()
	if (player_sprite == 2) then
		player_sprite += 1
	elseif (player_sprite ==3) then
		player_sprite -= 1
	end
end