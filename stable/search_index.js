var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "NCEI.jl Documentation",
    "title": "NCEI.jl Documentation",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#NCEI.jl-Documentation-1",
    "page": "NCEI.jl Documentation",
    "title": "NCEI.jl Documentation",
    "category": "section",
    "text": "CurrentModule = NCEINCEI.jl provides an interface for the National Centers for Environmental Information (NCEI) API services including the NCDC\'s Climate Data Online (CDO) Web Services v2.Please be sure to cite properly the datasets used from the National Centers for Environmental Information (NCEI). Please cite this package using the provided (Image: DOI).Pages = [\"GettingStarted.md\",\n				 \"Walkthrough.md\"]"
},

{
    "location": "GettingStarted.html#",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "page",
    "text": ""
},

{
    "location": "GettingStarted.html#Getting-Started-1",
    "page": "Getting Started",
    "title": "Getting Started",
    "category": "section",
    "text": ""
},

{
    "location": "GettingStarted.html#Installation-1",
    "page": "Getting Started",
    "title": "Installation",
    "category": "section",
    "text": "The package can be installed using:using Pkg\nPkg.add(\"NCEI\")Once installed it can be loaded using as any other Julian packageusing NCEI"
},

{
    "location": "GettingStarted.html#NCEI.cdo_datasets",
    "page": "Getting Started",
    "title": "NCEI.cdo_datasets",
    "category": "function",
    "text": "cdo_datasets(CDO_token::AbstractString, dataset::AbstractString)\ncdo_datasets(CDO_token::AbstractString;\n            datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n            locations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n            stations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n            startdate::Date = Date(\"0001-01-01\"),\n            enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_datacategories",
    "page": "Getting Started",
    "title": "NCEI.cdo_datacategories",
    "category": "function",
    "text": "cdo_datacategories(CDO_token::AbstractString, datacategory::AbstractString)\ncdo_datacategories(CDO_token::AbstractString;\n                   datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n                   locations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n                   stations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n                   startdate::Date = Date(\"0001-01-01\"),\n                   enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_datatypes",
    "page": "Getting Started",
    "title": "NCEI.cdo_datatypes",
    "category": "function",
    "text": "cdo_datatypes(CDO_token::AbstractString, datatype::AbstractString)\ncdo_datatypes(CDO_token::AbstractString;\n              datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              locations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              stations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              startdate::Date = Date(\"0001-01-01\"),\n              enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_locationcategories",
    "page": "Getting Started",
    "title": "NCEI.cdo_locationcategories",
    "category": "function",
    "text": "cdo_locationcategories(CDO_token::AbstractString, locationcategory::AbstractString)\ncdo_locationcategories(CDO_token::AbstractString;\n                       datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n                       startdate::Date = Date(\"0001-01-01\"),\n                       enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_locations",
    "page": "Getting Started",
    "title": "NCEI.cdo_locations",
    "category": "function",
    "text": "cdo_locations(CDO_token::AbstractString, location::AbstractString)\ncdo_locations(CDO_token::AbstractString;\n              datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              locationcategories::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n              startdate::Date = Date(\"0001-01-01\"),\n              enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_stations",
    "page": "Getting Started",
    "title": "NCEI.cdo_stations",
    "category": "function",
    "text": "cdo_stations(CDO_token::AbstractString, station::AbstractString)\ncdo_stations(CDO_token::AbstractString;\n             datasets::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n             locations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n             datacategories::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n             datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n             extent::Union{AbstractVector{<:AbstractFloat}} = Vector{Float64}(),\n             startdate::Date = Date(\"0001-01-01\"),\n             enddate::Date = today())\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#NCEI.cdo_data",
    "page": "Getting Started",
    "title": "NCEI.cdo_data",
    "category": "function",
    "text": "cdo_data(CDO_token::AbstractString, dataset::AbstractString, startdate::Date, enddate::Date;\n         datatypes::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n         locations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n         stations::Union{AbstractString, AbstractVector{<:AbstractString}} = \"\",\n         metric::Bool = true)\n\nFor obtaining a CDO_token: Request Web Services Token\n\nFor additional information visit the NCDC\'s Climate Data Online (CDO) Web Services v2 Documentation\n\n\n\n\n\n"
},

{
    "location": "GettingStarted.html#Documentation-for-the-Climate-Data-Online-(CDO)-API-1",
    "page": "Getting Started",
    "title": "Documentation for the Climate Data Online (CDO) API",
    "category": "section",
    "text": "cdo_datasets\ncdo_datacategories\ncdo_datatypes\ncdo_locationcategories\ncdo_locations\ncdo_stations\ncdo_data"
},

{
    "location": "Walkthrough.html#",
    "page": "Walkthrough",
    "title": "Walkthrough",
    "category": "page",
    "text": ""
},

{
    "location": "Walkthrough.html#Walkthrough-1",
    "page": "Walkthrough",
    "title": "Walkthrough",
    "category": "section",
    "text": "Set UpAfter installing the package one can call it in a new session as any other package. A good practice is to define the cdo_token one intends to use for that session.using NCEI\nconst cdo_token = ENV[\"cdo_token\"]\n# A token has form: r\"[A-Za-z]{32}\"DatasetsOne should first inspect the datasets available to select the ones the appropriate ones. Good information about a dataset is its ID which one needs to query data from that dataset, the temporal coverage, and documentation that can be accessed through the uid. For example, the daily summaries dataset (GHCND) has uid: C00861. The information for this dataset can be accessed at: https://data.nodc.noaa.gov/cgi-bin/iso?id=gov.noaa.ncdc:C00861.# Fetch all available datasets\ncdo_datasets(cdo_token)# Fetch all information about the GSOY dataset specifically\ncdo_datasets(cdo_token, \"GSOY\")# Fetch all available datasets with the Temperature at the time of observation (TOBS) data type\ncdo_datasets(cdo_token, datatypes = \"TOBS\")# Fetch all available datasets with data for a given set of stations\ncdo_datasets(cdo_token, stations = \"GHCND:USC00010008\")Data CategoriesThe next step is to find the data categories one might need (e.g., temperature vs precipitation).# Fetch all available data categories\nhead(cdo_datacategories(cdo_token))# Fetch all information about the Annual Agricultural dataset specifically\ncdo_datacategories(cdo_token, \"ANNAGR\")# Fetch data categories for a given set of locations\nhead(cdo_datacategories(cdo_token, locations = [\"FIPS:37\", \"CITY:US390029\"]))Data TypesNow we can inspect which variables we want to query from what data set.# Fetch available data types\nhead(cdo_datatypes(cdo_token))# Fetch more information about the ACMH data type id\ncdo_datatypes(cdo_token, \"ACMH\")# Fetch data types with the air temperature data category\nhead(cdo_datatypes(cdo_token, datacategories = \"TEMP\"))# Fetch data types that support a given set of stations\nhead(cdo_datatypes(cdo_token, stations = [\"COOP:310090\", \"COOP:310184\", \"COOP:310212\"]))Location CategoriesWe must identify the spatial constraints of the search and that can be accomplished at various levels (e.g., State vs Zip code).# Fetch all available location categories\nhead(cdo_locationcategories(cdo_token))# Fetch more information about the climate region location category\ncdo_locationcategories(cdo_token, \"CLIM_REG\")# Fetch available location categories that have data after 1970\nhead(cdo_locationcategories(cdo_token, startdate = Date(\"1970-01-01\")))LocationsNow select which locations are of interest.# Fetch available locations\nhead(cdo_locations(cdo_token))# Fetch more information about location id FIPS:37\ncdo_locations(cdo_token, \"FIPS:37\")# Fetch available locations for the GHCND (Daily Summaries) dataset\nhead(cdo_locations(cdo_token, datasets = \"GHCND\"))# Fetch all U.S. States\nhead(cdo_locations(cdo_token, locationcategories = \"ST\"))StationsLastly, one can obtain the relevant stations and verify their spatial information, temporal coverage, and data quality. To select from feasible weather stations one can use packages such as Distances.jl to obtain the nearest acceptable weather station to the desired location.# Fetch a list of stations that support a given set of data types\nhead(cdo_stations(cdo_token, datatypes = [\"EMNT\", \"EMXT\", \"HTMN\"]))# Fetch all information about the Abbeville AL station specifically\ncdo_stations(cdo_token, \"COOP:010008\")# Fetch all the stations in North Carolina, US (FIPS:37)\nhead(cdo_stations(cdo_token, locations = \"FIPS:37\"))DataThe final step is to obtain the raw data itself. A few transformations are recommended before proceeding with the analysis of the data (e.g., transforming the dataframe from long to short and filling the missing records with missing values for those observations). Read the documentation to interpret the various flags under the attributes column.# Fetch data from the GHCND dataset (Daily Summaries) for zip code 28801, May 1st of 2010\nhead(cdo_data(cdo_token, \"GHCND\", Date(\"2010-05-01\"), Date(\"2010-05-01\"),\n              locations = \"ZIP:28801\"))# Fetch data from the PRECIP_15 dataset (Precipitation 15 Minute) for COOP station 010008, for May of 2010 with metric units\nhead(cdo_data(cdo_token, \"PRECIP_15\", Date(\"2010-05-01\"), Date(\"2010-05-31\"),\n              stations = \"COOP:010008\"))# Fetch data from the GSOM dataset (Global Summary of the Month) for GHCND station USC00010008, for May of 2010 with standard units\nhead(cdo_data(cdo_token, \"GSOM\", Date(\"2010-05-01\"), Date(\"2010-05-31\"),\n              stations = \"GHCND:USC00010008\", metric = false))"
},

]}
