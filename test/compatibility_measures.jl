using Test 
using ForceBundle: Point, Edge, intersection_point

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


@testset "visibility" begin
    p0 = Point(0.,0.)
    p1 = Point(1.,1.)
    q1 = Point(-1.,1.)

    # perpendicular edges 
    P = Edge(p0, p1)
    Q = Edge(p0, q1)
    @test ForceBundle.visibility(P,Q) == 0
    @test ForceBundle.visibility(Q,P) == 0
end 