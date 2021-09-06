using Test, ForceBundle, StructArrays, LinearAlgebra

@testset "bundling" begin
    p0 = Point(0.,0.)
    p1 = Point(2.,0.)
    P = Edge(p0,p1)
    @test ForceBundle.nodes(P)[1] == p0
    @test ForceBundle.nodes(P)[2] == (p0 + p1)/2
    @test ForceBundle.nodes(P)[end] == p1
    @test length(ForceBundle.nodes(P)) == 3

    forces = ListOfNodes([Point(0.,1.)])
    ds = 0.1 

    ForceBundle.bundle!(P, forces, ds) 
    @test ForceBundle.nodes(P)[1] == p0
    @test ForceBundle.nodes(P)[2] == (p0 + p1)/2 + Point(0.,0.1)
    @test ForceBundle.nodes(P)[end] == p1
    @test length(ForceBundle.nodes(P)) == 3

end 


@testset "update divisions" begin
    aux1 = Point(2.,1.)
    aux2 = Point(0.5,0.)

    a = Point(0.,0.)
    b = a + 2.5 * aux1
    c = b + aux2
    z = sqrt((4 * sqrt(5) - norm(b-a) - norm(c-b))^2 - (7. - c.x)^2) + c.y
    d = Point(7., z)

    original_edge = ListOfNodes([a,b,c,d])
    new_edge = ForceBundle.update_divisions(Edge(original_edge), 3)
    new_nodes = ForceBundle.nodes(new_edge)

    @test ForceBundle.bundled_length(original_edge) ≈ 4 * sqrt(5)
    @test aux1 ≈ new_nodes[2]
    @test 2 * aux1 + a ≈ new_nodes[3]
    @test d + sqrt(5)*(c-d)/norm(c-d) ≈ new_nodes[4]
    @test d ≈ new_nodes[5]
end 