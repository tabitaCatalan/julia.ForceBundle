using Test, ForceBundle 


read_edges = ForceBundle.read_edges_csv("testcase.csv")

p0 = Point(-1.,0.)
p1 = Point(0.,1.)
q0 = Point(0.,-1.)
q1 = Point(1.,0.)

P = Edge(p0, p1)
Q = Edge(q0, q1) 

function are_equal(edge1, edge2)
    for (node1, node2) in zip(ForceBundle.nodes(edge1), ForceBundle.nodes(edge2))
        if node1 != node2
            return false 
        end 
    end
    return true 
end 

@testset "read edges from csv" begin 
    @test are_equal(P, read_edges[1])
    @test are_equal(Q, read_edges[2])
end 