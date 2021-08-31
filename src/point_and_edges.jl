using StructArrays, StaticArrays, LinearAlgebra 

struct Point{T} <: FieldVector{2, T}
    x::T
    y::T
end

struct Edge{T<:AbstractFloat, A <: AbstractVector{Point{T}}}
    nodes::A
end 

source(P::Edge) = P.nodes[1]
target(P::Edge) = P.nodes[end]

function Edge(source::Point, target::Point, subdivisions = 1)
    N = subdivisions
    nodos = StructArray(source + i/(N+1) * (target - source) for i in 0:(N+1))
    Edge(nodos)
end


nodes(P::Edge) = @view P.nodes[:]
subdivisions(P::Edge) = length(P.nodes) - 2

inner_range(P::Edge) = 2:subdivisions(P)+1
inner_nodes(P::Edge) = @view nodes(P)[inner_range(P)]

midpoint(P::Edge) = (source(P) + target(P))/2
asvector(P::Edge) = target(P) - source(P)
len(P::Edge) = norm(asvector(P))

