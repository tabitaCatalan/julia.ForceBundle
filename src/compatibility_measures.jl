using LinearAlgebra:inv 

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

# Notes 
See this [Issue in python.ForceBundle](https://github.com/tabitaCatalan/python.ForceBundle/issues/3)
for further discussion. 
A Kroki diagram could be usefull here.
"""
function intersection_point(q0::Point, vecQ::Point, P::Edge)
    vecP = asvector(P)
    p0 = source(P)
    aux = inverseofconcated(vecP,vecQ) * (q0 - p0)
    intersection = aux[1] * vecP + p0
    intersection 
end

inverseofconcated(d::Point,v::Point) = inv(hcat(d, v))

function proyectpoint(q::Point, m, P::Edge)
    x_proyection = (-m * q.x + q.y + slope(P)*source(P).x - source(P).y)/(slope(P) - m)
    y_proyection = slope(P) * (x_proyection - source(P).x) + source(P).y

    Point(x_proyection, y_proyection)
end

function proyectedEdge(Q,P)
    m = -1/slope(Q)
    Edge(proyectpoint(source(Q), m, P), proyectpoint(target(Q), m, P))
end

function visibility(P::Edge, Q::Edge)
    I = proyectedEdge(Q,P)
    Im = midpoint(I)
    Pm = midpoint(P)
    max(1. - 2. * norm(Pm - Im)/norm(source(I) - target(I)), 0.0)
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
