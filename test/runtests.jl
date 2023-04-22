using NCEI
using Test: @test, @test_throws, @testset

const CDO_TOKEN = "ijrAfEVJJAefHdruUsTkjRyWLqSZpBhY" # Dedicated CDO token for testing

@testset "Testing NCEI" begin
    @testset "Endpoint: Data Categories" begin
        all_datacategories = cdo_datacategories(CDO_TOKEN)
        @test size(all_datacategories) == (42, 2)
        one_data_category = cdo_datacategories(CDO_TOKEN, "ANNAGR")
        @test size(one_data_category) == (1, 2)
        datacategory_location = cdo_datacategories(CDO_TOKEN, locations = "CITY:US390029")
        @test size(datacategory_location) == (39, 2)
        @test_throws ArgumentError("N7 is not a valid data category. For a complete list of valid data categories run `cdo_datacategories(CDO_token::AbstractString)`.") cdo_datacategories(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Datasets" begin
        all_datasets = cdo_datasets(CDO_TOKEN)
        @test size(all_datasets) == (11, 6)
        one_dataset = cdo_datasets(CDO_TOKEN, "GSOY")
        @test size(one_dataset) == (1, 5)
        one_datatype = cdo_datasets(CDO_TOKEN, datatypes = "TOBS")
        @test size(one_datatype) == (1, 6)
        station = cdo_datasets(CDO_TOKEN, stations = "GHCND:USC00010008")
        @test size(station) == (6, 6)
        @test_throws ArgumentError("N7 is not a valid dataset. For a complete list of valid datasets run `cdo_datasets(CDO_token::AbstractString)`.") cdo_datasets(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Data Types" begin
        all_datatypes = cdo_datatypes(CDO_TOKEN)
        @test size(all_datatypes) == (1566, 5)
        one_datatype = cdo_datatypes(CDO_TOKEN, "ACMH")
        @test size(one_datatype) == (1, 4)
        datacategory = cdo_datatypes(CDO_TOKEN, datacategories = "TEMP")
        @test size(datacategory) == (59, 5)
        datacategories = cdo_datatypes(CDO_TOKEN,
                                       stations = ["COOP:310090", "COOP:310184", "COOP:310212"])
        @test size(datacategories) == (21, 5)
        @test_throws ArgumentError("N7 is not a valid data type. For a complete list of valid data types run `cdo_datatypes(CDO_token::AbstractString)`.") cdo_datatypes(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Location Categories" begin
        all_locationcategories = cdo_locationcategories(CDO_TOKEN)
        @test size(all_locationcategories) == (12, 2)
        one_locationcategory = cdo_locationcategories(CDO_TOKEN, "CLIM_REG")
        @test size(one_locationcategory) == (1, 2)
        @test_throws ArgumentError("N7 is not a valid location category. For a complete list of valid location categories run `cdo_locationcategories(CDO_token::AbstractString)`.") cdo_locationcategories(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Locations" begin
        all_locations = cdo_locations(CDO_TOKEN,
                                      datasets = "GHCND",
                                      locationcategories = "ST")
        @test size(all_locations) == (51, 5)
        one_location = cdo_locations(CDO_TOKEN, "FIPS:37")
        @test size(one_location) == (1, 5)
        @test_throws ArgumentError("N7 is not a valid location. For a complete list of valid locations run `cdo_locations(CDO_token::AbstractString)`.") cdo_locations(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Stations" begin
        station = cdo_stations(CDO_TOKEN, "COOP:010008")
        @test size(station) == (1, 9)
        location = cdo_stations(CDO_TOKEN,
                                locations = "FIPS:37",
                                startdate = Date(2000, 1, 1),
                                enddate = Date(2000, 1, 1))
        @test size(location) == (384, 9)
        @test_throws ArgumentError("N7 is not a valid weather station. For a complete list of valid stations run `cdo_stations(CDO_token::AbstractString)`.") cdo_stations(CDO_TOKEN, "N7")
    end
    @testset "Endpoint: Data" begin
        GHCND = cdo_data(CDO_TOKEN,
                         "GHCND",
                         Date(2010, 5, 1),
                         Date(2010, 5, 1),
                         locations = "ZIP:28801")
        @test size(GHCND) == (8, 5)
        station = cdo_data(CDO_TOKEN,
                           "PRECIP_15",
                           Date(2010, 5, 1),
                           Date(2010, 5, 31),
                           stations = "COOP:010008")
        @test size(station) == (63, 5)
        GSOM = cdo_data(CDO_TOKEN,
                        "GSOM",
                        Date(2010, 5, 1),
                        Date(2010, 5, 31),
                        stations = "GHCND:USC00010008")
        @test size(GSOM) == (13, 5)
        Yearly = cdo_data(CDO_TOKEN,
                          "GHCND",
                          Date(2000, 1, 1),
                          Date(2002, 12, 31),
                          datatypes = "TAVG",
                          locations = "ZIP:91711")
        @test size(Yearly) == (1093, 5)
        Decade = cdo_data(CDO_TOKEN,
                          "GSOY",
                          Date(1990, 1, 1),
                          Date(2001, 12, 31),
                          datatypes = "TAVG",
                          locations = "ZIP:91711")
        @test size(Decade) == (3, 5)
    end
    @testset "Are these valid arguments?" begin
        @test_throws ArgumentError cdo_datacategories(CDO_TOKEN, locations = "California")
        @test_throws ArgumentError cdo_datasets(CDO_TOKEN, stations = "USC00010008")
        @test_throws ArgumentError cdo_datatypes(CDO_TOKEN, datacategories = "temp")
    end
end
