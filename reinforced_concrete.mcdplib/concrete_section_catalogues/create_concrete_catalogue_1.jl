using Pkg
Pkg.activate(".")
using CSV
using DataFrames

include("../../src/myMCDP.jl")

# variables to populate
section_width_list = [100, 150, 200, 250]

section_ratio_list = [1, 1.5, 2.0]

comp_depth_ratio_list = [0.1, 0.2, 0.3, 0.4, 0.5]

concrete_strength_list = [28, 35, 45]

F_variables = ["section_width", 
            #    "section_depth", 
            "compression_depth", 
            "concrete_strength", 
            "moment_arm"]
F_units     = ["mm", 
            # "mm",
            "mm", 
            "N/mm/mm", 
            "mm"]

R_variables = ["concrete_carbon"]
R_units     = ["kg/mm"]


F_variables_full = ["section_width", 
                "section_depth", 
                "compression_depth", 
                "concrete_strength", 
                "moment_arm"]

F_units_full     = ["mm", 
                "mm",
                "mm", 
                "N/mm/mm", 
                "mm"]

R_variables_full = R_variables
R_units_full     = R_units

# -------------------------------------------------------------------
# 1. Build the output dataframe with correct headers
# -------------------------------------------------------------------

function build_headers(F_variables, F_units, R_variables, R_units)
    f_headers = ["F_$(name)_$(unit)" for (name, unit) in zip(F_variables, F_units)]
    r_headers = ["R_$(name)_$(unit)" for (name, unit) in zip(R_variables, R_units)]
    return vcat(f_headers, r_headers)
end

headers = build_headers(F_variables, F_units, R_variables, R_units)
df = DataFrame(fill(Any[], length(headers)), headers)

headers_full = build_headers(F_variables_full, F_units_full, R_variables_full, R_units_full)
df_full = DataFrame(fill(Any[], length(headers_full)), headers_full)

# -------------------------------------------------------------------
# 2. Loop and populate dataframe
# -------------------------------------------------------------------

global counter = 0

for section_width in section_width_list
    for section_ratio in section_ratio_list
        for comp_depth_ratio in comp_depth_ratio_list
            for concrete_strength in concrete_strength_list

                global counter += 1

                section_depth = section_width * section_ratio
                compression_depth = comp_depth_ratio * section_depth

                moment_arm = (section_depth - compression_depth / 2)

                concrete_carbon = section_width * section_depth * concrete_strength
                concrete_carbon /= 10e6
                
                # Append row
                push!(df, (
                    section_width,
                    # section_depth,
                    compression_depth,
                    concrete_strength,
                    moment_arm,
                    concrete_carbon
                ))

                push!(df_full, (
                    section_width,
                    section_depth,
                    compression_depth,
                    concrete_strength,
                    moment_arm,
                    concrete_carbon
                ))
            end
        end
    end
end

# -------------------------------------------------------------------
# 3. Save CSV
# -------------------------------------------------------------------

pathToCsv = "reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1.csv"
CSV.write(pathToCsv, df)
println("Saved $pathToCsv with ", nrow(df), " rows.")

pathToCsv_full = "reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1_full.csv"
CSV.write(pathToCsv_full, df_full)
println("Saved (full) $pathToCsv_full with ", nrow(df_full), " rows.")


# -------------------------------------------------------------------
# 4. Make the .yaml file from the csv file (not the full one)
# -------------------------------------------------------------------
pathToYaml = "reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1.yaml"
myMCDP.convert_csv_to_yaml(pathToCsv, saveFilePath = pathToYaml)
