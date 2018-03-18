# Locations
"""
    cdo_locations(CDO_token::AbstractString, location::AbstractString)
    cdo_locations(CDO_token::AbstractString;
                  datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  startdate::Date = Date("1763-01-01"),
                  enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#locations)
"""
function cdo_locations(CDO_token::AbstractString, location::AbstractString)
    obj = parse_url(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/locations/" * location)
    if isempty(obj)
        throw(ArgumentError("$location is not a valid location. For a complete list of valid locations run `cdo_locations(CDO_token::AbstractString)`."))
    else
        output = DataFrame(obj)
        output = output[[:id, :name, :mindate, :maxdate, :datacoverage]]
    end
    return output
end
function cdo_locations(CDO_token::AbstractString;
                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       startdate::Date = Date("1763-01-01"),
                       enddate::Date = today())
    url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/locations?" *
           id_or_chain(datasets, "dataset") *
           id_or_chain(locationcategories, "locationcategory") *
           id_or_chain(datacategories, "datacategory") *
           "startdate=" * string(startdate) * "&" *
           "enddate=" * string(enddate)
    obj = parse_urls(CDO_token, url)
    if isempty(obj)
        output = DataFrame(id = Vector{String}(),
                           name = Vector{String}(),
                           mindate = Vector{Date}(),
                           maxdate = Vector{Date}(),
                           datacoverage = Vector{Float64}())
    else
        output = DataFrame()
        for col ∈ ["id", "name", "mindate", "maxdate", "datacoverage"]
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
