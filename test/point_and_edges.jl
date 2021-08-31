using Test, ForceBundle  

@testset "point struct" begin
    p0 = Point(1.,2.)
    @test p0.x == 1. 
    @test p0.y == 2.
end;

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
