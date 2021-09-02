using Test, ForceBundle  

@testset "Angle compatibility" begin
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
    @test ForceBundle.Ca(P, Q) == ForceBundle.Ca(P_new_pos, Q) # invariance to length 
    @test ForceBundle.Ca(P, Q) == ForceBundle.Ca(P_long, Q) # invariance under displacement 
    @test ForceBundle.Ca(P,Q) == ForceBundle.Ca(Q,P) # symmetry  
    @test ForceBundle.Ca(P, Q) > 0
    @test ForceBundle.Ca(P, S) == 0
    @test ForceBundle.Ca(P, R) == 0
    @test ForceBundle.Ca(P, V) == 0
    @test ForceBundle.Ca(P, T) > 0
end 
