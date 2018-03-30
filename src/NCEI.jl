__precompile__(true)

module NCEI

using Dates: Day, Date, DateTime, TimeType, today, Year
using DataFrames: DataFrame
using HTTP: request
using LazyJSON: value # Needs to be run first in MacOS for some reason
using LazyJSON.PropertyDicts: get

import Base: names, parse

using Reexport: @reexport
@reexport using DataFrames

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
