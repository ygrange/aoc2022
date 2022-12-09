### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ a511fd3b-b083-4936-bb78-4980b6425be5
using HTTP

# ╔═╡ 5504544e-5381-4e20-8d5f-d4c47655f5f5
open("session.dat") do sess_file
  global session_cookie = Dict("session" => read(sess_file, String))
end;

# ╔═╡ 1638482b-cbdf-479e-97b9-522e787333a0
begin
data_response = HTTP.get("https://adventofcode.com/2022/day/7/input", cookies=session_cookie);
raw_data =String(data_response.body)
end

# ╔═╡ 485dc615-92ec-4108-80e0-27962bd111fb
work_data = split(raw_data,"\n")[begin:end-1]

# ╔═╡ 4ceaf5ad-1d68-4d8d-afd4-321ebd0d5bb7
function get_dir(path, dirdict)
	directory = dirdict
	for pathpart in path
		directory = directory[pathpart]
	end
	directory
end

# ╔═╡ 30431edc-81db-40c6-ba62-249bff961794
demostructure = Dict("a"=>1000, "b"=>Dict("c"=>100, "d"=>200))

# ╔═╡ b7ba6b7a-7547-4763-ae24-0b3ddea7df50
function read_in_data(dataset)
	dirstructure = Dict()
global listing = false
for cli_line in dataset
    if startswith(cli_line, raw"$ cd")
		cd_to_path = cli_line[6:end]
		if cd_to_path == "/"
			global current_dir = []
		elseif cd_to_path == ".."
			pop!(current_dir)
		else
			push!(current_dir, cd_to_path)
			current_dir_obj[cd_to_path]  = Dict()
			push!(all_paths, deepcopy(current_dir))
		end
		global current_dir_obj = get_dir(current_dir, dirstructure)
	end
	if listing && startswith(cli_line, raw"$")
		global listing = false
	end
	if listing
        (fsize, fname) = split(cli_line)
		if fsize != "dir"
			file_size = parse(Int, fsize)
			current_dir_obj[fname] = fsize
		end
	end
	if cli_line == raw"$ ls"
        global listing = true
	end
end
	dirstructure
end

# ╔═╡ cbcb5312-e85a-473f-8c35-fb9d506c0b1d
dirstructure = read_in_data(work_data)

# ╔═╡ 26a4af09-2f51-408c-9dd0-6f4b3a05260b
function add_up_dirsizes(dir_dict)
	total_size = 0
	size_list = Vector()
	for dir_item in keys(dir_dict)
		if typeof(dir_dict[dir_item]) == Dict{Any, Any}
			subdir_size_obj = add_up_dirsizes(dir_dict[dir_item])
			subdir_size = subdir_size_obj[1]
			append!(size_list, subdir_size_obj[2])
			push!(size_list, subdir_size)
		    total_size += subdir_size
		else
			total_size += parse(Int, dir_dict[dir_item])
		end
	end
	[total_size, size_list]
end

# ╔═╡ 39b61f9b-6430-4437-9365-39728b7df867
(total_size, allsizes) = add_up_dirsizes(dirstructure)

# ╔═╡ c6e55679-95ea-4616-88cf-778e4ecbebe2
println("Sum of all directories smaller than 100000: ", sum(allsizes[allsizes.<100000]))

# ╔═╡ a056e0c2-58e7-4ff7-a19c-72a0d8736704
begin
full_size = 70000000
size_needed = 30000000
current_free = full_size - total_size
extra_free_needed = size_needed - current_free
sorted_sizes = sort(allsizes)
deldir = sorted_sizes[sorted_sizes .≥ extra_free_needed][1]
println("Smallest size directory to delete: ", deldir)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"

[compat]
HTTP = "~1.5.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.2"
manifest_format = "2.0"
project_hash = "f3e12818d79d35ab70781d89b14a3d00c4df0f7c"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "e1acc37ed078d99a714ed8376446f92a5535ca65"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.5.5"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "df6830e37943c7aaa10023471ca47fb3065cc3c4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6e9dba33f9f2c44e08a020b0caf6903be540004"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.19+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "e4bdc63f5c6d62e80eb1c0043fcc0360d5950ff7"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.10"

[[deps.URIs]]
git-tree-sha1 = "ac00576f90d8a259f2c9d823e91d1de3fd44d348"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═a511fd3b-b083-4936-bb78-4980b6425be5
# ╠═5504544e-5381-4e20-8d5f-d4c47655f5f5
# ╠═1638482b-cbdf-479e-97b9-522e787333a0
# ╠═485dc615-92ec-4108-80e0-27962bd111fb
# ╠═4ceaf5ad-1d68-4d8d-afd4-321ebd0d5bb7
# ╠═30431edc-81db-40c6-ba62-249bff961794
# ╠═b7ba6b7a-7547-4763-ae24-0b3ddea7df50
# ╠═cbcb5312-e85a-473f-8c35-fb9d506c0b1d
# ╠═26a4af09-2f51-408c-9dd0-6f4b3a05260b
# ╠═39b61f9b-6430-4437-9365-39728b7df867
# ╠═c6e55679-95ea-4616-88cf-778e4ecbebe2
# ╠═a056e0c2-58e7-4ff7-a19c-72a0d8736704
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
