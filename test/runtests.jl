using NCEI
using Test: @test, @test_throws, @testset

const cdo_token = ENV["cdo_token"]

@testset "Testing NCEI" begin
    @testset "Endpoint: Data Categories" begin
        all_datacategories = cdo_datacategories(cdo_token)
        @test size(all_datacategories) == (42, 2)
        one_data_category = cdo_datacategories(cdo_token, "ANNAGR")
        @test size(one_data_category) == (1, 2)
        datacategory_location = cdo_datacategories(cdo_token, locations = "CITY:US390029")
        @test size(datacategory_location) == (38, 2)
    end
    @testset "Endpoint: Datasets" begin
        all_datasets = cdo_datasets(cdo_token)
        @test size(all_datasets) == (11, 6)
        one_dataset = cdo_datasets(cdo_token, "GSOY")
        @test size(one_dataset) == (1, 5)
        one_datatype = cdo_datasets(cdo_token, datatypes = "TOBS")
        @test size(one_datatype) == (1, 6)
        station = cdo_datasets(cdo_token, stations = "GHCND:USC00010008")
        @test size(station) == (6, 6)
    end
    @testset "Endpoint: Data Types" begin
        all_datatypes = cdo_datatypes(cdo_token)
        @test size(all_datatypes) == (1527, 5)
        one_datatype = cdo_datatypes(cdo_token, "ACMH")
        @test size(one_dataset) == (1, 4)
        datacategory = cdo_datatypes(cdo_token, datacategories = "TEMP")
        @test size(datacategory) == (59, 5)
        datacategories = cdo_datatypes(cdo_token, stations = ["COOP:310090", "COOP:310184", "COOP:310212"])
        @test size(datacategories) == (21, 5)
    end
    @testset "Endpoint: Location Categories" begin
        all_locationcategories = cdo_locationcategory(cdo_token)
        @test size(all_locationcategories) == (1527, 5)
        one_locationcategory = cdo_locationcategories(cdo_token, "CLIM_REG")
        @test size(one_locationcategory) == (1, 2)
        locationcategory = cdo_locationcategories(cdo_token, startdate = Date("1970-01-01"))
        @test size(locationcategory) == (12, 2)
    end
    @testset "Endpoint: Locations" begin
        all_locations = cdo_locations(cdo_token)
        @test size(all_locations) == (38860, 5)
        one_location = cdo_locations(cdo_token, "FIPS:37")
        @test size(one_location) == (1, 5)
        location = cdo_locations(cdo_token, datasets = "GHCND")
        @test size(location) == (28195, 5)
    end
    @testset "Endpoint: Stations" begin
        station = cdo_stations(cdo_token, "COOP:010008")
        @test size(station) == (1, 9)
        location = cdo_stations(cdo_token, locations = "FIPS:37")
        @test size(location) == (2481, 9)
        stations = cdo_stations(cdo_token, datatypes = ["EMNT", "EMXT", "HTMN"])
        @test size(stations) == (12699, 9)
    end
    @testset "Endpoint: Data" begin
        GHCND = cdo_data(cdo_token, "GHCND", Date("2010-05-01"), Date("2010-05-01"), locations = "ZIP:28801")
        @test size(GHCND) == (8, 5)
        station = cdo_data(cdo_token, "PRECIP_15", Date("2010-05-01"), Date("2010-05-31"), stations = "COOP:010008")
        @test size(station) == (63, )
        GSOM = cdo_data(cdo_token, "GSOM", Date("2010-05-01"), Date("2010-05-31"), stations = "GHCND:USC00010008")
        size(GSOM) == (10, 5)
    end
end;
