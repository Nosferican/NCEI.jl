# Examples

- Set Up

```@example Tutorial
using NCEI
cdo_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

## Climate Data Online (CDO)

- Datasets

```@example Tutorial
# Fetch all available datasets
# cdo_datasets(cdo_token)

# Fetch all information about the GSOY dataset specifically
# cdo_datasets(cdo_token, "GSOY")

# Fetch all available datasets with the Temperature at the time of observation (TOBS) data type
# cdo_datasets(cdo_token, datatypes = "TOBS")

# Fetch all available datasets with data for a given set of stations
# cdo_datasets(cdo_token, stations = "GHCND:USC00010008")
```

- Data Categories

```@example Tutorial
# Fetch all available data categories
# cdo_datacategories(cdo_token)

# Fetch all information about the Annual Agricultural dataset specifically
# cdo_datacategories(cdo_token, "ANNAGR")

# Fetch data categories for a given set of locations
# cdo_datacategories(cdo_token, locations = ["FIPS:37", "CITY:US390029"])
```

- Data Types

```@example Tutorial
# Fetch available data types
# cdo_datatypes(cdo_token)

# Fetch more information about the ACMH data type id
# cdo_datatypes(cdo_token, "ACMH")

# Fetch data types with the air temperature data category
# cdo_datatypes(cdo_token, datacategory = "TEMP")

# Fetch data types that support a given set of stations
# cdo_datatypes(cdo_token, stations = ["COOP:310090", "COOP:310184", "COOP:310212"])
```

- Location Categories

```@example Tutorial
# Fetch all available location categories
# cdo_locationscategories(cdo_token)

# Fetch more information about the climate region location category
# cdo_locationscategories(cdo_token, "CLIM_REG")

# Fetch available location categories that have data after 1970
# cdo_locationscategories(cdo_token, startdate = Date("1970-01-01"))
```

- Locations

```@example Tutorial
# Fetch available locations
# cdo_locations(cdo_token)

# Fetch more information about location id FIPS:37
# cdo_locations(cdo_token, "FIPS:37")

# Fetch available locations for the GHCND (Daily Summaries) dataset
cdo_locations(cdo_token, datasets = "GHCND")

# Fetch all U.S. States
cdo_locations(cdo_token, locationcategories = "ST")
```

- Stations

```@example Tutorial
# Fetch all available stations
# cdo_stations(cdo_token)

# Fetch all information about the Abbeville AL station specifically
# cdo_stations(cdo_token, "COOP:010008")

Fetch all the stations in North Carolina, US (FIPS:37)
# cdo_stations(cdo_token, locations = "FIPS:37")

Fetch a list of stations that support a given set of data types
# cdo_stations(cdo_token, datatypes = ["EMNT", "EMXT", "HTMN"])
```

- Data

```@example Tutorial
# Fetch data from the GHCND dataset (Daily Summaries) for zip code 28801, May 1st of 2010
# cdo_data(cdo_token, "GHCND", Date("2010-05-01"), Date("2010-05-01"), locations = "ZIP:28801")

# Fetch data from the PRECIP_15 dataset (Precipitation 15 Minute) for COOP station 010008, for May of 2010 with metric units
# cdo_data(cdo_token, "PRECIP_15", Date("2010-05-01"), Date("2010-05-31"), stations = "COOP:010008")

# Fetch data from the GSOM dataset (Global Summary of the Month) for GHCND station USC00010008, for May of 2010 with standard units
# cdo_data(cdo_token, "GSOM", Date("2010-05-01"), Date("2010-05-31"), stations = "GHCND:USC00010008")
```

## Historical Observing Metadata Repository (HOMR)

- Status: WIP
