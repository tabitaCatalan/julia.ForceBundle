using Test 
using ForceBundle: Point, Edge, intersection_point, source, target, halfpi_rotation

@testset "angle compatibility" begin
    # Points 
    aux = Point(2.,5.)
    p0 = Point(0.,0.)
    p1 = Point(1.,1.)
    q1 = Point(0.,1.)
    r1 = Point(-1.,1.)
    s1 = Point(-1.,-2.)
    t1 = Point(3.,-1.)
    v1 = Point(1.,-1.)

    # Edges, all but P_new_pos have source (0,0)
    P = Edge(p0, p1)
    P_new_pos = Edge(p0 + aux, p1 + aux) # same edge in new position 
    P_long = Edge(p0, 3 * p1) # same direction edge but longer 
    Q = Edge(p0,q1)
    R = Edge(p0,r1)
    S = Edge(p0,s1)
    T = Edge(p0,t1)
    V = Edge(p0,v1)

    # tests 
    @test ForceBundle.Ca(P, Q) ≈ ForceBundle.Ca(P_new_pos, Q) # invariance to length 
    @test ForceBundle.Ca(P, Q) ≈ ForceBundle.Ca(P_long, Q) # invariance under displacement 
    @test ForceBundle.Ca(P,Q) ≈ ForceBundle.Ca(Q,P) # symmetry  
    @test ForceBundle.Ca(P, Q) ≈ cos(π/4)
    @test ForceBundle.Ca(P, S) == 0
    @test ForceBundle.Ca(P, R) == 0
    @test ForceBundle.Ca(P, V) == 0
    @test ForceBundle.Ca(P, T) > 0
end 

@testset "intersection: simple case" begin
    #=
    Punto de intersección de la recta que sale de `p` con 
    dirección `d` con la recta definida por la arista Q  
    =# 
    p = Point(1.,0.)
    d = Point(3.,1.)
    Q = Edge(Point(2.,3.), Point(3.,2.))

    x = Point(4.,1.)
    @test intersection_point(p,d,Q) == x 
    @test intersection_point(p,-d,Q) == x 
end 


@testset "intersection: vertical edge" begin
    #=
    Al usar la pendiente se podría generar algún problema
    =#
    p = Point(3.,1.)
    d = Point(-1.,-1.)
    Q = Edge(Point(1.,0.), Point(1.,1.))

    x = Point(1.,-1.)
    @test intersection_point(p,d,Q) == x
    @test intersection_point(p,-d,Q) == x
end 

@testset "intersection: horizontal edge" begin
    #=
    Al usar la pendiente se podría generar algún problema
    =#
    p = Point(1.,2.)
    d = Point(0.,-1.)
    Q = Edge(Point(0.,0.), Point(2.,0.))

    x = Point(1.,0.)
    @test intersection_point(p,d,Q) == x
    @test intersection_point(p,-d,Q) == x
end 

@testset "projected edge: simple case" begin
    #=
    project Q over the rect defined by P 
    =#
    Q = Edge(Point(0.,1.), Point(1.,0.))
    P = Edge(Point(-3.,4.), Point(-1.,3.))
    projected = ForceBundle.proyectedEdge(Q, P)
    @test source(projected) ≈ Point(1.,2.)
    @test target(projected) ≈ Point(7/3, 7/3 -1)
end 


@testset "projected edge: on horizontal edge" begin
    #=
    project Q over the rect defined by P 
    =#
    Q = Edge(Point(1.,0.), Point(2.,0.))
    P = Edge(Point(0.,1.), Point(3.,3.))
    projected = ForceBundle.proyectedEdge(Q, P)
    @test source(projected) ≈ Point(1.,1. + 2/3)
    @test target(projected) ≈ Point(2.,2. + 1/3)
end 

@testset "π/2 rotation" begin
    p1 = Point(1.,3.)
    p1rotated = halfpi_rotation(p1) 
    p2 = Point(-3.3, -1.2)
    p2rotated = halfpi_rotation(p2)
    @test p1rotated ≈ Point(-3.,1.)
    @test p2rotated ≈ Point(1.2,-3.3)
end 

@testset "intersection: at infinity" begin
    #=
    Punto de intersección de la recta que sale de `p` con 
    dirección `d` con la recta definida por la arista Q. 
    `d` es paralelo a la dirección definida por Q 
    =# 
    p = Point(1.,0.)
    d = Point(3.,1.)
    Q = Edge(Point(2.,1.), Point(-1.,0.))

    ∞ = Point(Inf,Inf)
    @test intersection_point(p,d,Q) == ∞
    @test intersection_point(p,-d,Q) == ∞
end

@testset "visibility: perpendicular edges" begin
    p0 = Point(0.,0.)
    p1 = Point(1.,1.)
    q1 = Point(-1.,1.)

    P = Edge(p0, p1)
    Q = Edge(p0, q1)
    @test ForceBundle.are_perpendicular(P,Q) 
    @test ForceBundle.visibility(P,Q) == 0
    @test ForceBundle.visibility(Q,P) == 0
end 

@testset "visibility: almost perpendicular edges" begin
    p0 = Point(0.,0.)
    p1 = Point(1.,1.)

    ϵ = 1e-8
    q1 = Point(-1.,1. + ϵ)
        
    P = Edge(p0, p1)
    Q = Edge(p0, q1)
    @test ~ForceBundle.are_perpendicular(P,Q) 
    @test abs(ForceBundle.visibility(P,Q)) ≤ ϵ
    @test abs(ForceBundle.visibility(Q,P)) ≤ ϵ
end 