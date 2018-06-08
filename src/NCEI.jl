__precompile__(true)
"""
    NCEI

The `NCEI` module provides an interface to the National Centers of Environmental
Information API. The Climate Data Online API is fully supported.

Please see the documenation for more information.
"""
module NCEI

using Dates: Day, Date, DateTime, TimeType, today, Year
using DataFrames: DataFrame
using HTTP: request
using LazyJSON: value # Needs to be run first in MacOS for some reason
using LazyJSON.PropertyDicts: get

import Base: names, parse

# Code from Reexport.jl
"""
    @reexport(ex::Expr)
Reexports the package (e.g., `@reexport using PkgA`).
"""
macro reexport(ex)
    isa(ex, Expr) && (ex.head == :module ||
                      ex.head == :using ||
                      (ex.head == :toplevel &&
                       all(e->isa(e, Expr) && e.head == :using, ex.args))) ||
        error("@reexport: syntax error")

    if ex.head == :module
        modules = convert(Vector{Any}, [ex.args[2]])
        ex = Expr(:toplevel, ex, :(using .$(ex.args[2])))
    elseif ex.head == :using && all(e->isa(e, Symbol), ex.args)
        modules = convert(Vector{Any}, [ex.args[end]])
    else
        modules = convert(Vector{Any}, [e.args[end] for e in ex.args])
    end

    esc(Expr(:toplevel, ex,
             [:(eval(Expr(:export, names($mod)...))) for mod in modules]...))
end

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
