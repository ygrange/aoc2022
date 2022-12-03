### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ f82786dc-72e8-11ed-2254-bb8f94073e36
open("input_3.dat") do bag_contents
  global bags_contents = readlines(bag_contents)
end

# ╔═╡ 62c5842e-d7b0-4089-aac8-fb8eaf3fefd1
function score_letter(letter)
	alphabet = append!(collect('a':'z'), collect('A':'Z'))
	indexin(letter, alphabet)[1]
end

# ╔═╡ 401989ed-39d1-4b55-861a-f6d636d326c8
function get_score_for_bag(bag_contents)
    half_length = div(length(bag_contents), 2)
	bag_half_1 = bag_contents[begin:half_length]
	bag_half_2 = bag_contents[half_length+1:end]
	score_letter(intersect(bag_half_1, bag_half_2))
end

# ╔═╡ b13f3144-0f22-404b-a3ea-f4ba557fd86a
sum_of_bagvals = mapreduce(get_score_for_bag, +, bags_contents)

# ╔═╡ 83429819-661a-4835-8d3a-9570a22597af
println("Sum of double items values: ", sum_of_bagvals)

# ╔═╡ b693bcdc-93d1-4458-a723-f5f9d05fe619
function get_score_for_combo(bag_combo)
    bag_combo_shared = intersect(bag_combo...)
	score_letter(bag_combo_shared)
end

# ╔═╡ 5fc6e2c3-b532-4940-aa59-21e86a8a9858
bags_contents_grouped = [
	[value for value in bags_contents[counter:counter+2]] 
	for counter in 
	range(start=1,stop=length(bags_contents), step=3)
]

# ╔═╡ a0933c19-b58a-4461-ac48-b39d4e2b1ddf
sum_of_bag_combos = mapreduce(get_score_for_combo, +, bags_contents_grouped)

# ╔═╡ fd8ba5dc-4b42-4ffe-ac52-00a478eda1ac
println("Sum of bag combination scores: ", sum_of_bag_combos)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╠═f82786dc-72e8-11ed-2254-bb8f94073e36
# ╠═62c5842e-d7b0-4089-aac8-fb8eaf3fefd1
# ╠═401989ed-39d1-4b55-861a-f6d636d326c8
# ╠═b13f3144-0f22-404b-a3ea-f4ba557fd86a
# ╠═83429819-661a-4835-8d3a-9570a22597af
# ╠═b693bcdc-93d1-4458-a723-f5f9d05fe619
# ╠═5fc6e2c3-b532-4940-aa59-21e86a8a9858
# ╠═a0933c19-b58a-4461-ac48-b39d4e2b1ddf
# ╠═fd8ba5dc-4b42-4ffe-ac52-00a478eda1ac
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
