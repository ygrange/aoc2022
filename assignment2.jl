### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 0ea3b5b3-1af2-461a-a55a-2fc2f53769d3
open("input_2.dat") do data_d1
  global stratguide = readlines(data_d1)
end

# ╔═╡ 73950a31-12cb-4be9-ad93-a61744a87cf8
begin
global rock = 1
global paper = 2
global scizzors = 3
end

# ╔═╡ ae8c2bd9-fcbb-4ae3-bac7-268897fc610b
function compute_score(my_turn, elf_turn)
	val_diff = my_turn - elf_turn
	if abs(val_diff) == 2
		val_diff = -sign(val_diff) # basically saying -2 becomes 1, 2 becomes -1
	end
	val_diff += 1
	round_score = val_diff*3 + my_turn
end

# ╔═╡ d31c559e-67b4-46b2-8a08-dbf4345a67e1
begin
global score_sum = 0
part1_map = Dict("X"=>rock, "Y"=>paper, "Z"=>scizzors, 
	             "A"=>rock, "B"=>paper, "C"=>scizzors)
for stratentry in stratguide
    elf_turn, my_turn = split(stratentry)
	global score_sum += compute_score(part1_map[my_turn], part1_map[elf_turn])
end
end

# ╔═╡ c89dc121-bb0d-4185-adcd-9791434270a8
println("Score for first interpretation is ", score_sum)

# ╔═╡ 76fbc355-1908-4a7a-9315-53e4a6f08fb9
begin
global lose = -1
global draw = 0
global win = 1
end

# ╔═╡ 8dc16979-6f98-4494-8476-445751352f23
begin
global score_sum_2 = 0

part2_map = Dict("X"=>lose, "Y"=>draw, "Z"=>win, 
	             "A"=>rock, "B"=>paper, "C"=>scizzors)
global score_sum2 = 0
for stratentry in stratguide
    elf_turn, result = split(stratentry)
	elf_value = part2_map[elf_turn]
	result_value = part2_map[result]
	my_value = mod(elf_value + result_value, 1:3)
	global score_sum_2 += compute_score(my_value, elf_value)
end
end

# ╔═╡ 8106062e-2c2e-453d-a64a-8562be0308c4
println("Score for first interpretation is ", score_sum_2)

# ╔═╡ Cell order:
# ╠═0ea3b5b3-1af2-461a-a55a-2fc2f53769d3
# ╠═73950a31-12cb-4be9-ad93-a61744a87cf8
# ╠═ae8c2bd9-fcbb-4ae3-bac7-268897fc610b
# ╠═d31c559e-67b4-46b2-8a08-dbf4345a67e1
# ╠═c89dc121-bb0d-4185-adcd-9791434270a8
# ╠═76fbc355-1908-4a7a-9315-53e4a6f08fb9
# ╠═8dc16979-6f98-4494-8476-445751352f23
# ╠═8106062e-2c2e-453d-a64a-8562be0308c4
