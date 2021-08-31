using CSV 

function read_edges_csv(csv_filename)
    ALdata = CSV.File(csv_filename, header = [:p0x, :p0y, :p1x, :p1y])
    edge_from_row = (row) -> Edge(Point(row.p0x, row.p0y), Point(row.p1x, row.p1y))
    edge_from_row.(ALdata)
end
