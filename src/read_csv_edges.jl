using CSV 

"""
    read_edges_csv(csv_filename; subdivisions = 1)
Read a csv file and returns an array of `Edge`s.
# Arguments 
- `csv_filename::String`: path to csv file. Data must be organized in 4 columns:

|`source.x`, `source.y`, `target.x`, `target.y`|
---|---|---|--- 

- `subdivisions = 1`: (optional) number of inner subdivisions of each `Edge`. By default, 
an single subdivision is added.

# Example 
If a `edges.csv` in directory contains the following info 
```
-1.0, 0.0, 0.0, 1.0
0.0, -1.0, 1.0, 0.0 
```
then `read_edges_csv` returns a list of two `Edge`s:
```julia 
julia> edges = ForceBundle.read_edges_csv("edges.csv")
2-element Array{Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}},1}:    
 Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}}(Point{Float64}[[-1.0, 0.0], [-0.5, 0.5], [0.0, 1.0]])
 Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}}(Point{Float64}[[0.0, -1.0], [0.5, -0.5], [1.0, 0.0]])
```
"""
function read_edges_csv(csv_filename; subdivisions = 1)
    ALdata = CSV.File(csv_filename, header = [:p0x, :p0y, :p1x, :p1y])
    edge_from_row = (row) -> Edge(Point(row.p0x, row.p0y), Point(row.p1x, row.p1y), subdivisions = subdivisions)
    edge_from_row.(ALdata)
end
