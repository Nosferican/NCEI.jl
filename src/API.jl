# Data
"""
    cdo_data(CDO_token::AbstractString, dataset::AbstractString, startdate::Date, enddate::Date;
             datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             metric::Bool = true)

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#data)
"""
function cdo_data(CDO_token::AbstractString, dataset::AbstractString,
                  startdate::TimeType, enddate::TimeType;
                  datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  metric::Bool = true)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(dataset) && throw(ArgumentError("The dataset is not valid."))
    return parse(CDO_Data(CDO_token, dataset, startdate, enddate, datatypes, locations, stations, metric))
end

# Data Categories
"""
    cdo_datacategories(CDO_token::AbstractString, datacategory::AbstractString)
    cdo_datacategories(CDO_token::AbstractString;
                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       startdate::Date = Date("0001-01-01"),
                       enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#dataCategories)
"""
function cdo_datacategories(CDO_token::AbstractString, datacategory::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(datacategory) && throw(ArgumentError("Data category is not valid."))
    output = parse(CDO_DataCategory(CDO_token, datacategory))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_datacategories(CDO_token::AbstractString;
                            datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                            locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                            stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                            startdate::Date = Date("0001-01-01"),
                            enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    return parse(CDO_DataCategories(CDO_token, datasets, locations, stations, startdate, enddate))
end

# Datasets
"""
    cdo_datasets(CDO_token::AbstractString, dataset::AbstractString)
    cdo_datasets(CDO_token::AbstractString;
                datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                startdate::Date = Date("0001-01-01"),
                enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#datasets)
"""
function cdo_datasets(CDO_token::AbstractString, dataset::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(dataset) && throw(ArgumentError("Dataset is not valid."))
    output = parse(CDO_Dataset(CDO_token, dataset))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_datasets(CDO_token::AbstractString;
                      datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      startdate::Date = Date("0001-01-01"),
                      enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    return parse(CDO_Datasets(CDO_token, datatypes, locations, stations, startdate, enddate))
end

# Data Types
"""
    cdo_datatypes(CDO_token::AbstractString, datatype::AbstractString)
    cdo_datatypes(CDO_token::AbstractString;
                  datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  startdate::Date = Date("0001-01-01"),
                  enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#dataTypes)
"""
function cdo_datatypes(CDO_token::AbstractString, datatype::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(datatype) && throw(ArgumentError("Datatype is not valid."))
    output = parse(CDO_DataType(CDO_token, datatype))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_datatypes(CDO_token::AbstractString;
                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       startdate::Date = Date("0001-01-01"),
                       enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    return parse(CDO_DataTypes(CDO_token, datasets, datacategories, locations, stations, startdate, enddate))
end

# Location Categories
"""
    cdo_locationcategories(CDO_token::AbstractString, locationcategory::AbstractString)
    cdo_locationcategories(CDO_token::AbstractString;
                           datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                           startdate::Date = Date("0001-01-01"),
                           enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#locationCategories)
"""
function cdo_locationcategories(CDO_token::AbstractString, locationcategory::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    output = parse(CDO_LocationCategory(CDO_token, locationcategory))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_locationcategories(CDO_token::AbstractString;
                                datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                                startdate::Date = Date("0001-01-01"),
                                enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    return parse(CDO_LocationCategories(CDO_token, datasets, startdate, enddate))
end

# Locations
"""
    cdo_locations(CDO_token::AbstractString, location::AbstractString)
    cdo_locations(CDO_token::AbstractString;
                  datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  startdate::Date = Date("0001-01-01"),
                  enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#locations)
"""
function cdo_locations(CDO_token::AbstractString, location::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(location) && throw(ArgumentError("Location is not valid."))
    output = parse(CDO_Location(CDO_token, location))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_locations(CDO_token::AbstractString;
                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       startdate::Date = Date("1763-01-01"),
                       enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    return parse(CDO_Locations(CDO_token, datasets, locationcategories, datacategories, startdate, enddate))
end

# Stations
"""
    cdo_stations(CDO_token::AbstractString, station::AbstractString)
    cdo_stations(CDO_token::AbstractString;
                 datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 extent::Union{AbstractVector{<:AbstractFloat}} = Vector{Float64}(),
                 startdate::Date = Date("0001-01-01"),
                 enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#stations)
"""
function cdo_stations(CDO_token::AbstractString, station::AbstractString)
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    isempty(station) && throw(ArgumentError("Station is not valid."))
    output = parse(CDO_Station(CDO_token, station))
    isa(output, Exception) && throw(output)
    return output
end
function cdo_stations(CDO_token::AbstractString;
                      datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      extent::Union{AbstractVector{<:AbstractFloat}} = Vector{Float64}(),
                      startdate::Date = Date("0001-01-01"),
                      enddate::Date = today())
    textwidth(CDO_token) == 32 || throw(CDO_NonValidToken)
    length(extent) ∈ [0, 4] || throw(ArgumentError("Extent must be of length 0 or 4."))
    return parse(CDO_Stations(CDO_token, datasets, locations, datacategories, datatypes, extent, startdate, enddate))
end
