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

# These are similar to concrete_section
section_width_list = [100, 150, 200, 250]
section_ratio_list = [1, 1.5, 2.0]
comp_depth_ratio_list = [0.1, 0.2, 0.3, 0.4, 0.5]

# to calculate this, I will need to get compression depth from the previous components, do
F_variables = ["moment_demand", "total_rebar_area", "moment_arm"]
F_units     = ["N*mm", "mm*mm", "mm"]

R_variables = ["rebar_carbon"]
R_units     = ["kg/mm"]

# -------------------------------------------------------------------
# 1. Build the output dataframe with correct headers
# -------------------------------------------------------------------


headers = build_headers(F_variables, F_units, R_variables, R_units)
df = DataFrame(fill(Any[], length(headers)), headers)

# -------------------------------------------------------------------
# 2. Loop and populate dataframe
# -------------------------------------------------------------------

global counter = 0

for section_width in section_width_list
    for section_ratio in section_ratio_list
        for comp_depth_ratio in comp_depth_ratio_list
            for n_per_row in n_per_row_list
                for rebar_size in rebar_size_list

                    global counter += 1

                    rebar_diameter = rebarSize_to_diameter_mm[rebar_size]
                    rebar_area    = pi * rebar_diameter ^ 2 / 4
                    total_rebar_area = n_per_row * rebar_area

                    rebar_total_weight = n_per_row * rebarSize_to_kg_per_m[rebar_size]
                    rebar_carbon = 40 * rebar_total_weight

                    section_depth = section_width * section_ratio
                    compression_depth = comp_depth_ratio * section_depth

                    moment_arm = (section_depth - compression_depth / 2)

                    # Append row
                    push!(df, (
                        moment_demand, 
                        total_rebar_area,
                        moment_arm,
                        rebar_carbon
                    ))
                end
            end
        end
    end
end

# -------------------------------------------------------------------
# 3. Save CSV
# -------------------------------------------------------------------

pathToCsv = "reinforced_concrete.mcdplib/rebar_layout_catalogues/rebar_layout_catalogue_1.csv"

CSV.write(pathToCsv, df)

println("Saved $pathToCsv with ", nrow(df), " rows.")

# -------------------------------------------------------------------
# 4. Make the .yaml file from the csv file
# -------------------------------------------------------------------
pathToYaml = "reinforced_concrete.mcdplib/rebar_layout_catalogues/rebar_layout_catalogue_1.yaml"
myMCDP.convert_csv_to_yaml(pathToCsv, saveFilePath = pathToYaml)
