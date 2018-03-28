__precompile__(true)

module NCEI

using LazyJSON: value # Needs to be run first in MacOS for some reason
using LazyJSON.PropertyDicts: get

using Dates: Day, Date, DateTime, TimeType, today, Year
using DataFrames: DataFrame
using HTTP: request

import Base: names, parse

include.(["Endpoint.jl", "API.jl"])

export
    Date,
    DateTime,
    cdo_datasets,
    cdo_datacategories,
    cdo_datatypes,
    cdo_locationcategories,
    cdo_locations,
    cdo_stations,
    cdo_data
end
