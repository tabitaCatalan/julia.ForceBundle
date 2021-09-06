using StructArrays, StaticArrays, LinearAlgebra 

struct Point{T} <: FieldVector{2, T}
    x::T
    y::T
end

#=
Usaré la interfaz ListOfNodes, que permite las siguientes operaciones 
=# 

const ListOfNodes{T} = StructArray{Point{T}, 1, NamedTuple{(:x, :y),Tuple{Vector{T},Vector{T}}}, Int}

function ListOfNodes(tuple::D) where D<:NamedTuple{(:x, :y),Tuple{V,V}} where V<:AbstractVector{T} where T
    StructArray{Point{T}, 1, D}(tuple) 
end 

function ListOfNodes(listofpoints::A) where A <: AbstractVector{Point{T}} where T 
    xs = [point.x for point in listofpoints]
    ys = [point.y for point in listofpoints]
    ListOfNodes((x = xs, y = ys)) 
end 

function ListOfNodes(source::Point{T}, target::Point{T}; subdivisions = 1) where T 
    N = subdivisions 
    ListOfNodes([source + i/(N+1) * (target - source) for i = 0:N+1]) 
end

function push_node!(list::ListOfNodes, node::Point)
    push!(StructArrays.components(list).x , node.x)
    push!(StructArrays.components(list).y , node.y)
end 

#=
Edge 
=#

struct Edge{T<:AbstractFloat, L <: ListOfNodes{T}}
    nodes::L
end 

source(P::Edge) = P.nodes[1]
target(P::Edge) = P.nodes[end]

function Edge(source::Point{T}, target::Point{T}, subdivisions=1) where T <: AbstractFloat
    Edge(ListOfNodes(source, target, subdivisions = subdivisions))
end


# NamedTuple{(:x, :y),Tuple{Vector{T},Vector{T}}}
# A = StructArray{Point{Float64}, 1, NamedTuple{(:x, :y),Tuple{Array{Int64,1},Array{Int64,1}}}}((x = [1,2], y = [3,4]))

nodes(P::Edge) = @view P.nodes[:]
node(P::Edge, i) = LazyRow(P.nodes, i)

subdivisions(P::Edge) = length(P.nodes) - 2

inner_range(P::Edge) = 2:subdivisions(P)+1
inner_nodes(P::Edge) = @view nodes(P)[inner_range(P)]

midpoint(P::Edge) = (source(P) + target(P))/2
asvector(P::Edge) = target(P) - source(P)
len(P::Edge) = norm(asvector(P))

#=
Utils: accessor to xs and ys 
=#
xs(structarray) = StructArrays.components(structarray, :x)
ys(structarray) = StructArrays.components(structarray, :y)