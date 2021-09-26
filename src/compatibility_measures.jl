using LinearAlgebra:inv, det 

# Auxiliar functions
avglen(P::Edge, Q::Edge) = (len(P) + len(Q))/2
slope(P::Edge) = asvector(P).y/asvector(P).x

"""
    intersection_point(q0::Point, vecQ::Point, P::Edge)
Return the `Point` where the rect which pass over `q0` with 
direction `vecQ` intersects the rect defined by the edge `P`.

# Example

```julia
julia> q0 = Point(1.,1.)
julia> vecQ = Point(-1.,-1.)
julia> P = Edge(Point(-1.,2.), Point(1.,2.))
julia> intersection_point(q0,vecQ,P)
2-element Point{Float64} with indices SOneTo(2):
 2.0
 2.0
```
"""
function intersection_point(q0::Point, vecQ::Point, P::Edge)
    vecP = asvector(P)
    p0 = source(P)
    aux = inverseofconcated(vecP,vecQ) * (q0 - p0)
    intersection = aux[1] * vecP + p0
    intersection 
end

inverseofconcated(d::Point,v::Point) = inv(hcat(d, v))
are_colinear(d1::Point, d2::Point) = det(hcat(d1, d2)) == 0
function are_perpendicular(P::Edge, Q::Edge)
    are_colinear(perpendicular_slope(P), asvector(Q))
end
"""
    halfpi_rotation(p::Point)
Return `p` after a π/2 in counter clockwise rotation.
# Example 
```julia
julia> halfpi_rotation(Point(1.,0.))
2-element Point{Float64} with indices SOneTo(2):
 -0.0
  1.0
```
"""
function halfpi_rotation(p::Point)
    Point(-p.y, p.x)
end 

"""
    perpendicular_slope(P::Edge)
See an Edge as a vector and return a Point after rotating in π/2.

# Example 

Define `P` as an `Edge`
```julia
julia> P = Edge(Point(1.,3.), Point(5.,1.));
```
`P` as a vector is simple `target(P) - source(P)`, ie `Point(4.,-2.)`.
Rotating in π/2 we obtain `Point(2.,4.)`.
```julia
julia> perpendicular_slope(P)
2-element Point{Float64} with indices SOneTo(2):
 2.0
 4.0
```
"""
perpendicular_slope(P::Edge) = halfpi_rotation(asvector(P))

"""
    proyectedEdge(Q::Edge,P::Edge)
Calculate the intersection between the visibility band of `Q`
and the rect defined by `P`, and return it as an Edge.

The _visibility band_ of an `Edge` `Q` is defined as the space 
between the straight lines perpendicular to `Q` passing by `source(Q)`
and `target(Q)`. 
"""
function proyectedEdge(Q::Edge,P::Edge)
    vecQ = perpendicular_slope(Q)

    Edge(intersection_point(source(Q), vecQ, P), intersection_point(target(Q), vecQ, P))
end

function visibility(P::Edge, Q::Edge)
    if are_perpendicular(P,Q)
        0 
    else 
        I = proyectedEdge(Q,P)
        Im = midpoint(I)
        Pm = midpoint(P)
        max(1. - 2. * norm(Pm - Im)/norm(source(I) - target(I)), 0.0)
    end
end

# Compatibility measures 

"""
    Ca(P::Edge, Q::Edge)
Angle compatibility, defined by  
```math 
\\max\\{0, \\frac{\\vec{P} \\cdot \\vec{Q}}{|P||Q|}\\}
```
"""
Ca(P::Edge, Q::Edge) = max(0., dot(asvector(P), asvector(Q))/(len(P)*len(Q)))

"""
    Cs(P::Edge, Q::Edge)
Scale compatibility, defined by 
```math 
\\frac{2}{\\frac{l_{PQ}}{\\min\\{|P|, |Q|\\}} + \\frac{\\max\\{|P|, |Q|\\}}{l_{PQ}}}
```
where 
```
l_{PQ} = \\frac{|P| + |Q|}{2}
```
"""
Cs(P::Edge, Q::Edge) = 2. /(avglen(P,Q)/min(len(P), len(Q)) + max(len(P), len(Q))/avglen(P,Q))

"""
    Cp(P::Edge, Q::Edge)
Position compatibility 
"""
Cp(P::Edge, Q::Edge) = avglen(P,Q) / (avglen(P,Q) + norm(midpoint(P) - midpoint(Q)))

"""
    Cv(P::Edge, Q::Edge)
Visibility compatibility 
"""
Cv(P::Edge, Q::Edge) = visibility(P,Q) * visibility(Q,P)

# TODO: Podría hacer que se puedan elegir nuevas formas de compatibilidad, que sea extendible
"""
    compatibility(P::Edge, Q::Edge)
Default compatibility measure 
"""
compatibility(P::Edge, Q::Edge) = Ca(P,Q) * Cs(P,Q) * Cp(P,Q) * Cv(P,Q)
