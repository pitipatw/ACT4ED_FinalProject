using CSV
using DataFrames

include("yaml_generator.jl")

# variables to populate
fc′_list = [28, 35, 45]
b_list = [100, 125, 150, 175, 200, 225, 250]
ratio_list = [1, 1.5, 2.0]

d_list = b_list * ratio_list'
d_list = d_list[:]  # flatten matrix to vector

compression_ratio_list = [0.1, 0.2, 0.3, 0.4, 0.5]

F_variables = ["moment_capacity"]
F_units     = ["Nmm"]

R_variables = ["fc", "b", "d", "compression_area"]
R_units     = ["N/mm", "mm", "mm", "mm2"]

# --------------------------------------------------
# 1. Build the output dataframe with correct headers
# --------------------------------------------------

function build_headers(F_variables, F_units, R_variables, R_units)
    f_headers = ["F_$(name)_$(unit)" for (name, unit) in zip(F_variables, F_units)]
    r_headers = ["R_$(name)_$(unit)" for (name, unit) in zip(R_variables, R_units)]
    return vcat(f_headers, r_headers)
end

headers = build_headers(F_variables, F_units, R_variables, R_units)
df = DataFrame(fill(Any[], length(headers)), headers)

# ------------------------------
# 2. Loop and populate dataframe
# ------------------------------

counter = 0

for fc′ in fc′_list
    for b in b_list
        for d in d_list
            for comp_ratio in compression_ratio_list

                counter += 1

                # Compute compression area
                compression_area = b * d * comp_ratio

                # Compute moment capacity 
                moment_capacity = 0.85 * fc′ * compression_area

                # Append row
                push!(df, (
                    moment_capacity,
                    fc′,
                    b,
                    d,
                    compression_area
                ))
            end
        end
    end
end

# -------------------------------------------------------------------
# 3. Save CSV
# -------------------------------------------------------------------

CSV.write("generated_data.csv", df)

println("Saved generated_data.csv with ", nrow(df), " rows.")
