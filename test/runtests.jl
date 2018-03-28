using NCEI
using Test: @test, @test_throws, @testset

# const cdo_token = ""

@testset "Testing NCEI" begin
    @testset "Endpoint: Data Categories" begin
        all_datasets = cdo_datasets(cdo_token)
        @test size(all_datasets) == (2, 42)
        gsoy = cdo_datasets(cdo_token, "GSOY")
        @test size(gsoy) == (2, 1)
        tobs = cdo_datasets(cdo_token, datatypes = "TOBS")
        @test size(tobs) = (2, 1)
        station = cdo_datasets(cdo_token, stations = ["COOP:310090" "COOP:310184", "COOP:310212"])
        @test true
    end
    @testset "Endpoint: Datasets" begin

    end
    @testset "Endpoint: Data Types" begin

    end
    @testset "Endpoint: Location Categories" begin

    end
    @testset "Endpoint: Locations" begin

    end
    @testset "Endpoint: Stations" begin

    end
    @testset "Endpoint: Locations" begin

    end
    @testset "Endpoint: Data" begin

    end
end
