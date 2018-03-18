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
function cdo_data(CDO_token::AbstractString, dataset::AbstractString, startdate::TimeType, enddate::TimeType;
                  datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  locations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  stations::Union{AbstractString, AbstractVector{<:AbstractString}} = "",
                  metric::Bool = true)
    urls = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data?datasetid=" * dataset * "&" *
            id_or_chain(datatypes, "datatype") *
            id_or_chain(locations, "location") *
            "units=" * ifelse(metric, "metric", "standard") *
            "&startdate=" .* string(startdate) .*
            "&enddate=" .* string(enddate)
    obj = parse_urls(CDO_token, urls)
    if isempty(obj)
        output = DataFrame(station = Vector{String}(),
                           date = Vector{DateTime}(),
                           datatype = Vector{String}(),
                           value = Vector{Float64}(),
                           attributes = Vector{String}())
    else
        output = DataFrame()
        for col ∈ ["station", "date", "datatype", "value", "attributes"]
            if col == "date"
                output[Symbol(col)] = DateTime.(get.(obj["results"], col, missing))
            else
                output[Symbol(col)] = get.(obj["results"], col, missing)
            end
        end
        sort!(output)
    end
end
