function wrap(a, size)
	if ( a < 1 ) then return size end
	if ( a > size ) then return 1 end
	return a
end

function deadOrAlive(table, x, y)
	neighbourCount = 0
	for i = -1, 1 do
		iksz = wrap(x + i, table.sizex)
		ipsz = wrap(y - 1, table.sizey)

		if table[iksz][ipsz] ~= nil then
			neighbourCount = neighbourCount + 1
		end

		ipsz = wrap(y + 1, table.sizey)

		if table[iksz][ipsz] ~= nil then
			neighbourCount = neighbourCount + 1
		end

		if table[iksz][y] ~= nil and i~= 0 then
			neighbourCount = neighbourCount + 1
		end
	end

	if ( neighbourCount == 3 ) then return 1 end

	if ( table[x][y] ~= nil ) then
		if ( neighbourCount < 2 ) then return nil end
		if ( neighbourCount == 2 ) then return 1 end
		if ( neighbourCount > 3 ) then return nil end	
	end
end

function prt(table)
	for i = 1, table.sizey do
		row = ""
		for j = 1, table.sizex do
			if ( table[j][i] ~= nil ) then char = "#"
			else char = "." end
			row = row .. char
		end
		print(row)
	end
	print("\n");
end

print("Mkay, so enter N, then X and Y.")
steps, sizex, sizey = io.read("*number", "*number", "*number")

io.read()

map = {}
buffer = {}

for i = 1,sizex do
	map[i] = {}
	buffer[i] = {}
	for j = 1,sizey do
		map[i][j] = nil
		buffer[i][j] = nil
	end
end

map.sizex = sizex
map.sizey = sizey
buffer.sizex = sizex
buffer.sizey = sizey

for i = 1,sizey do
	row = io.read()
	for j = 1,sizex do
		if string.sub(row,j,j) == "#" then map[j][i]=1 end
	end
end

for i = 1, steps do
	print("Step ", i-1)
	prt(map)
	for a = 1,sizex do
		for b = 1,sizey do
			buffer[a][b]=deadOrAlive(map, a, b)
		end
	end

	for a = 1, sizex do
		for b = 1, sizey do
			map[a][b]=buffer[a][b]
			buffer[a][b]=nil
		end
	end
end

print("Step ",i)
prt(map)
