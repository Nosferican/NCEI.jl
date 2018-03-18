# Location Categories
"""
    cdo_locationscategories(CDO_token::AbstractString, locationcategory::AbstractString)
    cdo_locationscategories(CDO_token::AbstractString;
                  datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  startdate::Date = Date("1763-01-01"),
                  enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#locationCategories)
"""
function cdo_locationscategories(CDO_token::AbstractString, locationcategory::AbstractString)
    obj = parse_url(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories/" * locationcategory)
    if isempty(obj)
        throw(ArgumentError("$locationcategory is not a valid location category. For a complete list of valid location categories run `cdo_locationscategories(CDO_token::AbstractString)`."))
    else
        output = DataFrame(obj)
        output = output[[:name, :id]]
    end
    return output
end
function cdo_locationscategories(CDO_token::AbstractString;
                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                       startdate::Date = Date("1763-01-01"),
                       enddate::Date = today())
    url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories?" *
           id_or_chain(datasets, "dataset") *
           "startdate=" * string(startdate) * "&" *
           "enddate=" * string(enddate)
    obj = parse_url(CDO_token, url)
    if isempty(obj)
        output = DataFrame(name = Vector{String}(), id = Vector{String}())
    else
        output = DataFrame()
        for col ∈ ["name", "id"]
            output[Symbol(col)] = get.(obj["results"], col, missing)
        end
        sort!(output)
    end
    return output
end
