# Datasets
"""
    cdo_datasets(CDO_token::AbstractString, dataset::AbstractString)
    cdo_datasets(CDO_token::AbstractString;
                datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                startdate::Date = Date("1763-01-01"),
                enddate::Date = today())

For obtaining a CDO_token: [Request Web Services Token](https://www.ncdc.noaa.gov/cdo-web/token)

For additional information visit the [NCDC's Climate Data Online (CDO) Web Services v2 Documentation](https://www.ncdc.noaa.gov/cdo-web/webservices/v2#datasets)
"""
function cdo_datasets(CDO_token::AbstractString, dataset::AbstractString)
    obj = parse_url(CDO_token, "https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets/" * dataset)
    if isempty(obj)
        throw(ArgumentError("$dataset is not a valid dataset. For a complete list of valid datasets run `cdo_datasets(CDO_token::AbstractString)`."))
    else
        output = DataFrame(obj)
        output = output[[:name, :id, :mindate, :maxdate, :datacoverage]]
        output[:mindate] = Date(output[:mindate])
        output[:maxdate] = Date(output[:maxdate])
    end
    return output
end
function cdo_datasets(CDO_token::AbstractString;
             datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
             startdate::Date = Date("1763-01-01"),
             enddate::Date = today())
    url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets?" *
           id_or_chain(datatypes, "datatype") *
           id_or_chain(locations, "location") *
           id_or_chain(stations, "station") *
           "startdate=" * string(startdate) * "&" *
           "enddate=" * string(enddate)
    obj = parse_url(CDO_token, url)
    if isempty(obj)
        output = DataFrame(name = Vector{String}(),
                           id = Vector{String}(),
                           mindate = Vector{Date}(),
                           maxdate = Vector{Date}(),
                           datacoverage = Vector{Float64}(),
                           uid = Vector{String}())
    else
        output = DataFrame()
        for col ∈ ["name", "id", "mindate", "maxdate", "datacoverage", "uid"]
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
