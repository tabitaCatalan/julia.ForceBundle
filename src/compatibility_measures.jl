
# Auxiliar functions
avglen(P::Edge, Q::Edge) = (len(P) + len(Q))/2
slope(P::Edge) = asvector(P).y/asvector(P).x

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
