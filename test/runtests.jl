using NCEI
using Test: @test, @test_throws, @testset

const cdo_token = ""

@testset "Testing NCEI" begin
    @testset "Endpoint: Data Categories" begin
        all_datasets = cdo_datasets(cdo_token)
        @test size(all_datasets) == (11, 6)
        gsoy = cdo_datasets(cdo_token, "GSOY")
        @test size(gsoy) == (1, 5)
        tobs = cdo_datasets(cdo_token, datatypes = "TOBS")
        @test size(tobs) == (1, 6)
        station = cdo_datasets(cdo_token, stations = "GHCND:USC00010008")
        @test size(station) == (6, 6)
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
end;
