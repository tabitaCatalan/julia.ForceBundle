using Test, ForceBundle  

@testset "point struct" begin
    p0 = Point(1.,2.)
    @test p0.x == 1. 
    @test p0.y == 2.
end;

@testset "list of nodes" begin
    p0 = Point(0.,0.)
    p1 = Point(0.,1.)
    p2 = Point(0.,2.)
    p3 = Point(0.,3.)
    p4 = Point(0.,4.)
    
    L0 = ListOfNodes(p0,p4, subdivisions = 0)
    L1 = ListOfNodes(p0,p4)
    L3 = ListOfNodes(p0,p4, subdivisions = 3) 
    
    # L0 
    @test L0[1] == p0
    @test L0[end] == p4 
    @test length(L0) == 2 

    # L1
    @test L1[1] == p0
    @test L1[2] == p2
    @test L1[end] == p4 
    @test length(L1) == 3
    
    # L3 
    @test L3[1] == p0
    @test L3[2] == p1
    @test L3[3] == p2
    @test L3[4] == p3
    @test L3[end] == p4
    @test length(L3) == 5
     
end 

@testset "pushing nodes to list" begin
    p0 = Point(0.,0.)
    p1 = Point(0.,1.)
    
    L = ListOfNodes(p0,p1, subdivisions = 0) 
    @test L[1] == p0
    @test L[end] == p1 
    @test length(L) == 2

    p2 = Point(0.,2.)

    ForceBundle.push_node!(L, p2)
    @test L[1] == p0
    @test L[2] == p1
    @test L[end] == p2 
    @test length(L) == 3
    
end 

@testset "list of nodes from list of points" begin
    #=
    test to create ListOfNodes from list of Points 
    =# 
    p1 = Point(0.,0.)
    p2 = Point(1.,2.)
    p3 = Point(1.,4.)
    L = ListOfNodes([p1, p2, p3])
    @test L[1] == p1
    @test L[2] == p2
    @test L[3] == p3 
    @test length(L) == 3
end  


@testset "edge struct" begin
    p0 = Point(1.,2.)
    p1 = Point(3.,3.)
    P =  Edge(p0,p1)
    @test ForceBundle.source(P) == p0 
    @test ForceBundle.target(P) == p1 
    @test ForceBundle.subdivisions(P) == 1 
    @test ForceBundle.midpoint(P) == Point(2.,2.5)
    @test ForceBundle.asvector(P) == Point(2.,1.)
    @test ForceBundle.len(P) == sqrt(5.)
end; 

@testset "nodes and inner nodes" begin
    p0 = Point(1.,2.)
    p1 = Point(3.,3.)
    phalf = (p0 + p1)/2 
    P =  Edge(p0,p1) # subdivisions = 1 
    L = ListOfNodes([p0, phalf, p1])
    innerL = ListOfNodes([phalf])
    @test ForceBundle.nodes(P) == L 
    @test ForceBundle.inner_nodes(P) == innerL 
end;