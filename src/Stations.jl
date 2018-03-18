# Stations
"""
    cdo_stations(CDO_token::AbstractString, station::AbstractString)
    cdo_stations(CDO_token::AbstractString;
                 datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                 extent::Union{AbstractVector{<:AbstractFloat}} = Vector{Float64}(),
                 startdate::Date = Date("1763-01-01"),
                 enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#stations)
"""
function cdo_stations(CDO_token::AbstractString, station::AbstractString)
    obj = parse_url(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations/" * station)
    if isempty(obj)
        throw(ArgumentError("$station is not a valid weather station. For a complete list of valid stations run `cdo_stations(CDO_token::AbstractString)`."))
    else
        output = DataFrame(obj)
        output = output[[:id, :name, :mindate, :maxdate, :datacoverage]]
    end
    return output
end
function cdo_stations(CDO_token::AbstractString;
                      datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                      extent::Union{AbstractVector{<:AbstractFloat}} = Vector{Float64}(),
                      startdate::Date = Date("1763-01-01"),
                      enddate::Date = today())
    if length(extent) ∉ [0, 4]
        throw(ArgumentError("extent must be of length 0 or 4."))
    end
    url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/stations?" *
           id_or_chain(datasets, "dataset") *
           id_or_chain(locations, "location") *
           id_or_chain(datacategories, "datacategory") *
           id_or_chain(datatypes, "datatype") *
           "extend=" * reduce(*, string.(extent) .* ",")[1:end - 1] *
           "&startdate=" * string(startdate) *
           "&enddate=" * string(enddate)
    obj = parse_urls(CDO_token, url)
    if isempty(obj)
        output = DataFrame(id = Vector{String}(),
                           name = Vector{String}(),
                           mindate = Vector{Date}(),
                           maxdate = Vector{Date}(),
                           datacoverage = Vector{Float64}(),
                           longitude = Vector{Float64}(),
                           latitude = Vector{Float64}(),
                           elevation = Vector{Float64}(),
                           elevationUnit = Vector{String}())
    else
        output = DataFrame()
        for col ∈ ["id", "name", "mindate", "maxdate", "datacoverage", "longitude", "latitude", "elevation", "elevationUnit"]
            if col ∈ ["mindate", "maxdate"]
                output[Symbol(col)] = Date.(get.(obj["results"], col, missing))
            else
                output[Symbol(col)] = get.(obj["results"], col, missing)
            end
        end
        sort!(output)
    end
    return output
end
