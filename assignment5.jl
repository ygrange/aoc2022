### A Pluto.jl notebook ###
# v0.19.14

using Markdown
using InteractiveUtils

# ╔═╡ ae14440c-73da-11ed-3461-3385002cde79
using HTTP

# ╔═╡ 7ccab57c-6191-4722-8216-6eee6f933af8
open("session.dat") do sess_file
  global session_cookie = Dict("session" => read(sess_file, String)) 
end;

# ╔═╡ 2a194dcd-bca2-4042-b5b4-58d5e51f3b04
begin
data_response = HTTP.get("https://adventofcode.com/2022/day/5/input", cookies=session_cookie);
raw_data = String(data_response.body)
end

# ╔═╡ 49b8a745-254a-4d2b-ba0e-4f96b81a7dc1
data_set = strip(raw_data);

# ╔═╡ c2a4db29-0fd9-4300-9edf-2d9a43e4b153
begin
analyse_data = split(rstrip(raw_data), "\n")
for (linenum, line) in enumerate(analyse_data)
if line == ""
    global cargo = analyse_data[begin:linenum-1]
	global steps = analyse_data[linenum+1:end]
end
end
end

# ╔═╡ ebd4bfc9-f1cd-415d-8377-6c16d04c1c43
begin
cargo_id_line = split(cargo[end],"")
cargo_readout = cargo_id_line .!= " "
global cargo_ids = cargo_id_line[cargo_readout]
global cargo_ixs = range(start=1, stop=length(cargo_id_line))[cargo_readout]
end

# ╔═╡ 79b26d23-bfc4-4ee4-aa92-94b2bdd4c388
begin
	cargo_list = Dict()
    for cargo_id in cargo_ids
		cargo_list[cargo_id] = Vector()
	end
	for cargo_row_str in cargo[begin:end-1]
		println(cargo_row_str)
		cargo_row = split(cargo_row_str, "")
		for (index_id, cargo_index) in enumerate(cargo_ixs)
			if cargo_row[cargo_index] != " "
				row_content = cargo_row[cargo_index]
				row_name = cargo_ids[index_id]
				pushfirst!(cargo_list[row_name], row_content)
			end
		end
	end
end

# ╔═╡ 84340386-5fa5-40a3-bc5f-13deb669a5d7
step_format=r"move (.*) from (.) to (.)"

# ╔═╡ 661588e9-6177-47d5-b9ba-ec2e16a5515e
begin
global cargo_list_pop = deepcopy(cargo_list)
for step in steps
	(num, fromcol, tocol) = match(step_format, step)
	for counter in range(length=parse(Int, num))
		push!(cargo_list_pop[tocol], pop!(cargo_list_pop[fromcol]))
	end
end
end

# ╔═╡ 1d2da444-df6a-43bc-afa8-6e6a4cafda0a
begin
print("Containers on top after moving one by one: ")
for cargo_col in cargo_ids
	print(cargo_list_pop[cargo_col][end])
end
	println()
end

# ╔═╡ 4d1f3677-f68e-4f66-9524-5a104066c012
begin
global cargo_list_splice = deepcopy(cargo_list)
for step in steps
    (num, fromcol, tocol) = match(step_format, step)
	splice_start = length(cargo_list_splice[fromcol]) - parse(Int, num) + 1
	splice_end = length(cargo_list_splice[fromcol])
	append!(cargo_list_splice[tocol], splice!(cargo_list_splice[fromcol], splice_start:splice_end))
end
end

# ╔═╡ 6c223e0b-31ad-45ed-84c8-1636c8d73b06
begin
print("Containers on top after moving multiple at once: ")
for cargo_col in cargo_ids
	print(cargo_list_splice[cargo_col][end])
end
	println()
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
project_hash = "a238b8da3173173c03efba28e2d62db224d48212"

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
# ╠═ae14440c-73da-11ed-3461-3385002cde79
# ╠═7ccab57c-6191-4722-8216-6eee6f933af8
# ╠═2a194dcd-bca2-4042-b5b4-58d5e51f3b04
# ╠═49b8a745-254a-4d2b-ba0e-4f96b81a7dc1
# ╠═c2a4db29-0fd9-4300-9edf-2d9a43e4b153
# ╠═ebd4bfc9-f1cd-415d-8377-6c16d04c1c43
# ╠═79b26d23-bfc4-4ee4-aa92-94b2bdd4c388
# ╠═84340386-5fa5-40a3-bc5f-13deb669a5d7
# ╠═661588e9-6177-47d5-b9ba-ec2e16a5515e
# ╠═1d2da444-df6a-43bc-afa8-6e6a4cafda0a
# ╠═4d1f3677-f68e-4f66-9524-5a104066c012
# ╠═6c223e0b-31ad-45ed-84c8-1636c8d73b06
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
