### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ 94fd4720-715a-11ed-288c-29ded7f0502f
open("input_1.dat") do data_d1
  data_set = read(data_d1, String)
  global elves_foods = split(data_set,"\n\n")[begin:end-2]
end

# ╔═╡ 96f22fbb-1e64-4465-9c48-e3c463cff35b
data_sums = Array{Int}([])

# ╔═╡ 12aa0a51-d928-441d-a95f-6f01564f07d3
for elf in elves_foods
	append!(data_sums, sum([parse(Int, val) for val in split(elf,'\n')]))
end

# ╔═╡ e0fd5b4e-1aee-49ff-b8de-5c36cd7c87c4
println(maximum(data_sums))

# ╔═╡ 71251fe0-c3ea-4814-84ed-b1cd00e0ad8c
println(sum(sort(data_sums)[end-2:end]))

# ╔═╡ 81c945ea-1291-4531-a88d-35aec7e8ec1e
sort(data_sums)

# ╔═╡ Cell order:
# ╠═94fd4720-715a-11ed-288c-29ded7f0502f
# ╠═96f22fbb-1e64-4465-9c48-e3c463cff35b
# ╠═12aa0a51-d928-441d-a95f-6f01564f07d3
# ╠═e0fd5b4e-1aee-49ff-b8de-5c36cd7c87c4
# ╠═71251fe0-c3ea-4814-84ed-b1cd00e0ad8c
# ╠═81c945ea-1291-4531-a88d-35aec7e8ec1e
