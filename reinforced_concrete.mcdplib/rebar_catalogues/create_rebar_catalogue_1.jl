using Pkg
Pkg.activate(".")
using CSV
using DataFrames

include("../../src/myMCDP.jl")

# Adopted from https://www.camblinsteel.com/post/rebar-sizing
rebarSize_to_diameter_mm = Dict(
    3  => 9.525,
    4  => 12.7,
    5  => 15.875,
    6  => 19.05,
    7  => 22.225,
    8  => 25.4,
    9  => 28.65,
    10 => 32.258,
    11 => 35.81,
    14 => 43.0,
    18 => 57.33
)

# rebar_density = 7850

rebarSize_to_kg_per_m = Dict(k => pi * (rebarSize_to_diameter_mm[k] / 1000) ^ 2 / 4 * 7850 for k in keys(rebarSize_to_diameter_mm))

# for i in [3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 18]
# println(rebarSize_to_kg_per_m[i])
# end

# variables to populate
rebar_size_list = [3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 18]
n_per_row_list = [1, 2, 3, 4]

b_list = [150, 175, 200, 225, 250]
ratio_list = [1, 1.5, 2.0]

d_list = b_list * ratio_list'
d_list = d_list[:]  # flatten matrix to vector

compression_ratio_list = [0.1, 0.2, 0.3, 0.4, 0.5]

# to calculate this, I will need to get compression depth from the previous components, do
F_variables = ["moment_capacity", "compression_area", "compression_force", "moment_demand"]
F_units     = ["Nmm", "mm2", "N", "Nmm"]

R_variables = ["mass", "number_per_row"]
R_units     = ["kg", "dimensionless"]

# -------------------------------------------------------------------
# 1. Build the output dataframe with correct headers
# -------------------------------------------------------------------


headers = build_headers(F_variables, F_units, R_variables, R_units)
df = DataFrame(fill(Any[], length(headers)), headers)

# -------------------------------------------------------------------
# 2. Loop and populate dataframe
# -------------------------------------------------------------------

global counter = 0

for rebar_size in rebar_size_list
    for n_per_row in n_per_row_list 
        for b in b_list
            for d in d_list
                for comp_ratio in  compression_ratio_list
        
                    global counter += 1

                    rebar_diameter = rebarSize_to_diameter_mm[rebar_size]
                    rebar_area    = pi * rebar_diameter ^ 2 / 4
                    total_rebar_area = n_per_row * rebar_area

                    compression_force = fy * total_rebar_area
                    compression_area = b * d * comp_ratio
                    moment_arm  = (d - d * comp_ratio / 2)

                    moment_capacity = fy * total_rebar_area * (d - d * comp_ratio / 2)

                    
                    rebar_total_weight = n_per_row * rebarSize_to_kg_per_m[rebar_size]

                    # Append row
                    push!(df, (
                        moment_capacity, compression_area, compression_force, moment_capacity,
                        rebar_total_weight, n_per_row
                    ))
                end
            end
        end
    end
end

# -------------------------------------------------------------------
# 3. Save CSV
# -------------------------------------------------------------------

pathToCsv = "reinforced_concrete.mcdplib/rebar_catalogues/rebar_catalogue_1.csv"

CSV.write(pathToCsv, df)

println("Saved $pathToCsv with ", nrow(df), " rows.")

# -------------------------------------------------------------------
# 4. Make the .yaml file from the csv file
# -------------------------------------------------------------------
pathToYaml = "reinforced_concrete.mcdplib/rebar_catalogues/rebar_catalogue_1.yaml"
myMCDP.convert_csv_to_yaml(pathToCsv, saveFilePath = pathToYaml)
