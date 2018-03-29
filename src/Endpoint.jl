# Helpers
id_or_chain(obj::AbstractString, kind::AbstractString) = kind * "id=" * obj * "&"
id_or_chain(obj::AbstractVector{<:AbstractString}, kind::AbstractString) = reduce(*, kind .* "id=" .* obj .* "&")
function period(startdate::TimeType, enddate::TimeType, dataset::AbstractString)
    starts = string.(startdate:ifelse(dataset ∈ ["GSOM", "GSOY"], Year(10), Year(1)):enddate)
    return "&startdate=" .* starts .* "&enddate=" .* push!(starts[2:end], string(enddate))
end
for_assignment(::Type{Union{Missing, T}}, value::Missing) where T <: Union{AbstractString, Number, TimeType} = missing
for_assignment(::Type{Union{Missing, T}}, value::AbstractString) where T <: AbstractString = convert(T, value)
for_assignment(::Type{Union{Missing, T}}, value::Number) where T <: Number = convert(T, value)
for_assignment(::Type{Union{Missing, T}}, value::AbstractString) where T <: TimeType = T(convert(String, value))
for_assignment(::Type{T}, value::Missing) where T <: Union{AbstractString, Number, TimeType} = missing
for_assignment(::Type{T}, value::AbstractString) where T <: AbstractString = convert(T, value)
for_assignment(::Type{T}, value::Number) where T <: Number = convert(T, value)
for_assignment(::Type{T}, value::AbstractString) where T <: TimeType = T(convert(String, value))

isvalid_cdotoken(obj::AbstractString) = occursin(r"[A-Za-z]{32}", obj)
isvalid_datsets(obj::AbstractVector{<:AbstractString}) = all(isvalid_datsets, obj)
isvalid_datsets(obj::AbstractString) = obj ∈ DATASETS
isvalid_datacategories(obj::AbstractVector{<:AbstractString}) = all(isvalid_datacategories, obj)
isvalid_datacategories(obj::AbstractString) = obj ∈ DATACATEGORIES
isvalid_datatypes(obj::AbstractVector{<:AbstractString}) = all(elem -> occursin(r"^[A-Z0-9-]{3,}$", elem), obj)
isvalid_datatypes(obj::AbstractString) = occursin(r"^[A-Z0-9-]{3,}$", obj)
isvalid_locationcategories(obj::AbstractVector{<:AbstractString}) = all(isvalid_locationcategories, obj)
isvalid_locationcategories(obj::AbstractString) = obj ∈ LOCATIONCATEGORIES
isvalid_locations(obj::AbstractVector{<:AbstractString}) = all(isvalid_locations, obj)
isvalid_locations(obj::AbstractString) = occursin(r"^(CITY|CLIM_DIV|CLIM_REG|CNTRY|CNTY|HYD_ACC|HYD_CAT|HYD_REG|HYD_SUB|ST|US_TERR|ZIP):[A-Z0-9]{1,}$", obj)
isvalid_stations(obj::AbstractVector{<:AbstractString}) = all(isvalid_stations, obj)
isvalid_stations(obj::AbstractString) = occursin(r"^(COOP|GHCND|NEXRAD|WBAN):[a-zA-Z0-9-_]{1,}$", obj)
isvalid_extent(obj::AbstractVector{<:AbstractFloat}) = length(extent) ∈ [0, 4]

# Struct
abstract type Endpoint end
struct CDO_Data <: Endpoint
    token::String
    url::Vector{String}
    function CDO_Data(CDO_token::AbstractString,
                      dataset::AbstractString,
                      startdate::TimeType,
                      enddate::TimeType,
                      datatypes::Union{AbstractString, AbstractVector{<:AbstractString}},
                      locations::Union{AbstractString, AbstractVector{<:AbstractString}},
                      stations::Union{AbstractString, AbstractVector{<:AbstractString}},
                      metric::Bool)
        url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data?datasetid=" * dataset * "&" *
              id_or_chain(datatypes, "datatype") *
              id_or_chain(locations, "location") *
              id_or_chain(stations, "station") *
              "units=" * ifelse(metric, "metric", "standard") .*
              period(startdate, enddate, dataset) .*
              "&limit=1000&offset=1"
        return new(CDO_token, url)
    end
end
struct CDO_DataCategory <: Endpoint
    token::String
    url::String
    CDO_DataCategory(CDO_token::AbstractString, datacategory::AbstractString) = new(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/datacategories/" * datacategory)
end
struct CDO_DataCategories <: Endpoint
    token::String
    url::String
    function CDO_DataCategories(CDO_token::AbstractString,
                                datasets::Union{AbstractString, AbstractVector{<:AbstractString}},
                                locations::Union{AbstractString, AbstractVector{<:AbstractString}},
                                stations::Union{AbstractString, AbstractVector{<:AbstractString}},
                                startdate::Date,
                                enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/datacategories?" *
                   id_or_chain(datasets, "dataset") *
                   id_or_chain(locations, "location") *
                   id_or_chain(stations, "station") *
                   "startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
    end
end
struct CDO_Dataset <: Endpoint
    token::String
    url::String
    CDO_Dataset(CDO_token::AbstractString, dataset::AbstractString) = new(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets/" * dataset)
end
struct CDO_Datasets <: Endpoint
    token::String
    url::String
    function CDO_Datasets(CDO_token::AbstractString,
                          datatypes::Union{AbstractString, AbstractVector{<:AbstractString}},
                          locations::Union{AbstractString, AbstractVector{<:AbstractString}},
                          stations::Union{AbstractString, AbstractVector{<:AbstractString}},
                          startdate::Date,
                          enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets?" *
                   id_or_chain(datatypes, "datatype") *
                   id_or_chain(locations, "location") *
                   id_or_chain(stations, "station") *
                   "startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
    end
end
struct CDO_DataType <: Endpoint
    token::String
    url::String
    CDO_DataType(CDO_token::AbstractString, datatype::AbstractString) = new(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/datatypes/" * datatype)
end
struct CDO_DataTypes <: Endpoint
    token::String
    url::String
    function CDO_DataTypes(CDO_token::AbstractString,
                           datasets::Union{AbstractString, AbstractVector{<:AbstractString}},
                           datacategories::Union{AbstractString, AbstractVector{<:AbstractString}},
                           locations::Union{AbstractString, AbstractVector{<:AbstractString}},
                           stations::Union{AbstractString, AbstractVector{<:AbstractString}},
                           startdate::Date,
                           enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/datatypes?" *
                   id_or_chain(datasets, "dataset") *
                   id_or_chain(datacategories, "datacategory") *
                   id_or_chain(locations, "location") *
                   id_or_chain(stations, "station") *
                   "startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
        end
end
struct CDO_LocationCategory <: Endpoint
    token::String
    url::String
    CDO_LocationCategory(token::AbstractString, locationcategory::AbstractString) = new(token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories/" * locationcategory)
end
struct CDO_LocationCategories <: Endpoint
    token::String
    url::String
    function CDO_LocationCategories(CDO_token::AbstractString,
                                    datasets::Union{AbstractString, AbstractVector{<:AbstractString}},
                                    startdate::Date,
                                    enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories?" *
                   id_or_chain(datasets, "dataset") *
                   "startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
    end
end
struct CDO_Location <: Endpoint
    token::String
    url::String
    CDO_Location(CDO_token::AbstractString, location::AbstractString) = new(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/locations/" * location)
end
struct CDO_Locations <: Endpoint
    token::String
    url::String
    function CDO_Locations(CDO_token::AbstractString,
                           datasets::Union{AbstractString, AbstractVector{<:AbstractString}},
                           locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}},
                           datacategories::Union{AbstractString, AbstractVector{<:AbstractString}},
                           startdate::Date,
                           enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/locations?" *
                   id_or_chain(datasets, "dataset") *
                   id_or_chain(locationcategories, "locationcategory") *
                   id_or_chain(datacategories, "datacategory") *
                   "startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
        end
end
struct CDO_Station <: Endpoint
    token::String
    url::String
    CDO_Station(CDO_token::AbstractString, station::AbstractString) = new(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations/" * station)
end
struct CDO_Stations <: Endpoint
    token::String
    url::String
    function CDO_Stations(CDO_token::AbstractString,
                          datasets::Union{AbstractString, AbstractVector{<:AbstractString}},
                          locations::Union{AbstractString, AbstractVector{<:AbstractString}},
                          datacategories::Union{AbstractString, AbstractVector{<:AbstractString}},
                          datatypes::Union{AbstractString, AbstractVector{<:AbstractString}},
                          extent::Union{AbstractVector{<:AbstractFloat}},
                          startdate::Date,
                          enddate::Date)
        return new(CDO_token,
                   "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?" *
                   id_or_chain(datasets, "dataset") *
                   id_or_chain(locations, "location") *
                   id_or_chain(datacategories, "datacategory") *
                   id_or_chain(datatypes, "datatype") *
                   "extend=" * reduce(*, string.(extent) .* ",")[1:end - 1] *
                   "&startdate=" * string(startdate) *
                   "&enddate=" * string(enddate) *
                   "&limit=1000&offset=1")
    end
end

# Constants
const CDO_Single = Union{CDO_DataCategory, CDO_Dataset, CDO_DataType, CDO_LocationCategory, CDO_Location, CDO_Station}
const CDO_Meta = Union{CDO_Data, CDO_DataCategories, CDO_Datasets, CDO_DataTypes, CDO_LocationCategories, CDO_Locations, CDO_Stations}
const DATASETS = ["GHCND", "GSOM", "GSOY", "NEXRAD2", "NEXRAD3", "NORMAL_ANN",
                  "NORMAL_DLY", "NORMAL_HLY", "NORMAL_MLY", "PRECIP_15", "PRECIP_HLY"]
const LOCATIONCATEGORIES = ["CITY", "CLIM_DIV", "CLIM_REG", "CNTRY", "CNTY", "HYD_ACC",
                            "HYD_CAT", "HYD_REG", "HYD_SUB", "ST", "US_TERR", "ZIP"]
const DATACATEGORIES = ["ANNAGR", "ANNDD", "ANNPRCP", "ANNTEMP", "AUAGR", "AUDD",
                        "AUPRCP", "AUTEMP", "COMP", "COMPAGR", "DD", "DUALPOLMOMENT",
                        "ECHOTOP", "EVAP", "HYDROMETEOR", "LAND", "MISC", "OTHER", "OVERLAY",
                        "PRCP", "PRES", "REFLECTIVITY", "SKY", "SPAGR", "SPDD", "SPPRCP", "SPTEMP",
                        "SUAGR", "SUDD", "SUN", "SUPRCP", "SUTEMP", "TEMP", "VELOCITY", "VERTINTLIQUID",
                        "WATER", "WIAGR", "WIDD", "WIND", "WIPRCP", "WITEMP", "WXTYPE"]
const CDO_NonValidToken = ArgumentError("The CDO_token is not valid.")
const CDO_NonValidDatasets = ArgumentError("The provided datasets argument is not valid. Valid datasets are: " * reduce(*, DATASETS .* ", ")[1:end - 2] * ".")
const CDO_NonValidDataCategories = ArgumentError("The data category argument is not valid. Valid data categories are: " * reduce(*, DATACATEGORIES .* ", ")[1:end - 2] * ".")
const CDO_NonValidDataTypes = ArgumentError("The provided datatypes argument is not valid. A valid data type has form r\"^[A-Z0-9-]{3,}$\"")
const CDO_NonValidLocationCategories = ArgumentError("The provided location categories argument is not valid. Valid location categories are: CITY, CLIM_DIV, CLIM_REG, CNTRY, CNTY, HYD_ACC, HYD_CAT, HYD_REG, HYD_SUB, ST, US_TERR, ZIP.")
const CDO_NonValidLocations = ArgumentError("The provided locations argument is not valid. A valid location has form r\"^(CITY|CLIM_DIV|CLIM_REG|CNTRY|CNTY|HYD_ACC|HYD_CAT|HYD_REG|HYD_SUB|ST|US_TERR|ZIP):[A-Z0-9]{1,}$\""
const CDO_NonValidStations = ArgumentError("The provided locations argument is not valid. A valid location has form r\"^(COOP|GHCND|NEXRAD|WBAN):[a-zA-Z0-9\-]{1,}$\"")
const CDO_NonValidExtent = ArgumentError("Extent must be of length 0 or 4.")

const Names = [[:date, :datatype, :station, :attributes, :value],
               [:name, :id],
               [:mindate, :maxdate, :name, :datacoverage, :id],
               [:uid, :mindate, :maxdate, :name, :datacoverage, :id],
               [:mindate, :maxdate, :datacoverage, :id],
               [:mindate, :maxdate, :name, :datacoverage, :id],
               [:elevation, :mindate, :maxdate, :latitude, :name, :datacoverage, :id, :elevationUnit, :longitude]
               ]
const Types = [[DateTime, String, String, Union{String, Missing}, Float64],
               [String, String],
               [Date, Date, String, Float64, String],
               [String, Date, Date, String, Float64, String],
               [Date, Date, Float64, String],
               [Date, Date, String, Float64, String],
               [Union{Float64 Missing}, Date, Date, Float64, String, Float64, String, Union{String, Missing}, Float64])
               ]

"""
    names(::Endpoint)::Vector{Symbol}

Return the names of the values from a json values stream in order for the endpoint.
"""
names(::Endpoint) = error("names is not defined for $(typeof(obj)).")
names(::CDO_Data) = Names[1]
names(::CDO_DataCategory) = Names[2]
names(::CDO_DataCategories) = Names[2]
names(::CDO_Dataset) = Names[3]
names(::CDO_Datasets) = Names[4]
names(::CDO_DataType) = Names[5]
names(::CDO_DataTypes) = Names[6]
names(::CDO_LocationCategory) = Names[2]
names(::CDO_LocationCategories) = Names[2]
names(::CDO_Location) = Names[6]
names(::CDO_Locations) = Names[6]
names(::CDO_Station) = Names[7]
names(::CDO_Stations) = Names[7]

"""
    types(::Endpoint)::Vector{Symbol}

Return the types of the values from a json values stream in order for the endpoint.
"""
types(::Endpoint) = error("types is not defined for $(typeof(obj)).")
types(::CDO_Data) = Types[1]
types(::CDO_DataCategory) = Types[2]
types(::CDO_DataCategories) = Types[2]
types(::CDO_Dataset) = Types[3]
types(::CDO_Datasets) = Types[4]
types(::CDO_DataType) = Types[5]
types(::CDO_DataTypes) = Types[3]
types(::CDO_LocationCategory) = Types[2]
types(::CDO_LocationCategories) = Types[2]
types(::CDO_Location) = Types[6]
types(::CDO_Locations) = Types[6]
types(::CDO_Station) = Types[7]
types(::CDO_Stations) = Types[7]

"""
    exception(::Endpoint)::DataFrame
    exception(::Endpoint)::ArgumentError(msg::AbstractString)

In case of no results for a data request, return either an empty DataFrame of
the expected type indicating no data for the query parameters or an ArgumentError
if it is the result can be deduced to be an error in the argument.
"""
exception(obj::Endpoint) = DataFrame(types(obj), names(obj), 0)
exception(obj::CDO_DataCategory) = ArgumentError(getfield(obj, :url)[57:end] * " is not a valid data category. For a complete list of valid data categories run `cdo_datacategories(CDO_token::AbstractString)`.")
exception(obj::CDO_Dataset) = ArgumentError(getfield(obj, :url)[51:end] * " is not a valid dataset. For a complete list of valid datasets run `cdo_datasets(CDO_token::AbstractString)`.")
exception(obj::CDO_DataType) = ArgumentError(getfield(obj, :url)[52:end] * " is not a valid data type. For a complete list of valid data types run `cdo_datatypes(CDO_token::AbstractString)`.")
exception(obj::CDO_LocationCategory) = ArgumentError(getfield(obj, :url)[61:end] * " is not a valid location category. For a complete list of valid location categories run `cdo_locationcategories(CDO_token::AbstractString)`.")
exception(obj::CDO_Location) = ArgumentError(getfield(obj, :url)[52:end] * " is not a valid location. For a complete list of valid locations run `cdo_locations(CDO_token::AbstractString)`.")
exception(obj::CDO_Station) = ArgumentError(getfield(obj, :url)[51:end] * " is not a valid weather station. For a complete list of valid stations run `cdo_stations(CDO_token::AbstractString)`.")

"""
    skeleton(endpoint::CDO_Single, jsontext::AbstractString)

Return a dataframe with the parse values of a JSON according to the endpoint.
In case of no observations an empty dataframe is returned.
If an empty JSON indicates an ArgumentError this one is throw.
"""
function skeleton(endpoint::CDO_Single, jsontext::AbstractString)
    jsontext == "{}" && return exception(endpoint)
    Ts, Ns = (types(endpoint), names(endpoint))
    Keys = string.(Ns)
    output = DataFrame(Ts, Ns, 1)
    vals = value(jsontext)
    for (col, T, key) ∈ zip(Ns, Ts, Keys)
        output[col] = for_assignment(T, get(vals, key, missing))
    end
    return output
end

"""
    parse(obj::Endpoint)

Return the results for the endpoint.
"""
parse(obj::Endpoint) = error("parse is not defined for $(typeof(obj)).")
function parse(obj::CDO_Single)
    response = request("GET", getfield(obj, :url), [("token", getfield(obj, :token))])
    jsontext = String(getfield(response, :body))
    return skeleton(obj, jsontext)
end
function parse(obj::CDO_Meta)
    header = [("token", getfield(obj, :token))]
    Ts, Ns = (types(obj), names(obj))
    Keys = string.(Ns)
    url = getfield(obj, :url)
    response = request("GET", url, header)
    jsontext = String(getfield(response, :body))
    jsontext == "{}" && return DataFrame(Ts, Ns, 0)
    json = value(jsontext)
    Count = Int64(json["metadata"]["resultset"]["count"])
    urls = url[1:end - 1] .* string.(1:1000:Count)[2:end]
    idx = 1
    output = DataFrame(Ts, Ns, Count)
    for elem ∈ json["results"]
        for (col, T, key) ∈ zip(Ns, Ts, Keys)
            output[idx, col] = for_assignment(T, get(elem, key, missing))
        end
        idx += 1
    end
    for suburl ∈ urls
        response = request("GET", suburl, header)
        jsontext = String(getfield(response, :body))
        json = value(jsontext)["results"]
        for elem ∈ json
            for (col, T, key) ∈ zip(Ns, Ts, Keys)
                output[idx, col] = for_assignment(T, get(elem, key, missing))
            end
            idx += 1
        end
    end
    return output
end
function parse(obj::CDO_Data)
    header = [("token", getfield(obj, :token))]
    urls = getfield(obj, :url)
    Ns, Ts = (names(obj), types(obj))
    Keys = string.(Ns)
    output = DataFrame(Ts, Ns, 0)
    for url ∈ urls
        response = request("GET", url, header)
        jsontext = String(getfield(response, :body))
        jsontext == "{}" && return DataFrame(Ts, Ns, 0)
        json = value(jsontext)
        Count = Int64(json["metadata"]["resultset"]["count"])
        urls = url[1:end - 1] .* string.(1:1000:Count)[2:end] .* "&includemetadata=false"
        tmp = DataFrame(Ts, Ns, Count)
        idx = 1
        for elem ∈ json["results"]
            for (col, T, key) ∈ zip(Ns, Ts, Keys)
                tmp[idx, col] = for_assignment(T, get(elem, key, missing))
            end
            idx += 1
        end
        for suburl ∈ urls
            response = request("GET", suburl, header)
            jsontext = String(getfield(response, :body))
            json = value(jsontext)["results"]
            for elem ∈ json
                for (col, T, key) ∈ zip(Ns, Ts, Keys)
                    tmp[idx, col] = for_assignment(T, get(elem, key, missing))
                end
                idx += 1
            end
        end
        append!(output, tmp)
    end
    return output
end
