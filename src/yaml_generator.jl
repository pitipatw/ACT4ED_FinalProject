using CSV
using DataFrames
using YAML

"""
Parse a header of the form:
    F_name_unit
    R_name_unit
Returns (:F or :R, name::String, unit::String)
"""
function parse_header(header::String)
    parts = split(header, "_")
    if length(parts) < 3
        error("Invalid header format: $header")
    end

    kind  = parts[1]               # "F" or "R"
    name  = join(parts[2:end-1], "_")
    unit  = parts[end]             # unit part

    return (Symbol(kind), name, unit)
end


"""
Extract ordered lists of F units and R units from headers.
Returns:
    f_units::Vector{String}
    r_units::Vector{String}
"""
function extract_units(headers::Vector{String})
    f_units = String[]
    r_units = String[]

    for h in headers
        (kind, _name, unit) = parse_header(h)
        if kind == :F
            push!(f_units, unit)
        elseif kind == :R
            push!(r_units, unit)
        else
            @warn "kind: $string(kind) not found, please recheck"
            @warn "unit will be pushed into r_units for now"
            push!(r_units, unit)
        end
    end

    return f_units, r_units
end


"""
Build implementations dictionary from CSV rows.
F columns come first in the CSV, R columns follow.
"""
function build_implementations(df::DataFrame, f_count::Int, f_units, r_units; 
    f_mode::String="max", r_mode::String="min")

    impls = Dict()

    for (model_index, row) in enumerate(eachrow(df))
        f_values = [ string(row[i], " ", f_units[i]) for i in 1:f_count ]
        r_values = [
            string(row[i], " ", r_units[i - f_count])
            for i in (f_count+1):ncol(df)
        ]

        impls["model$(model_index-1)"] = Dict(
            "f_$f_mode" => f_values,
            "r_$r_mode" => r_values
        )
    end

    return impls
end


"""
Main function to convert CSV into MCDP-style YAML.
"""
function convert_csv_to_yaml(path_to_csv::String;
    saveFilePath::String = "test.yaml",
    f_mode::String = "max",
    r_mode::String = "min"
)
    # Load CSV
    df = CSV.read(path_to_csv, DataFrame)

    # Split headers into F and R groups (order preserved)
    headers = names(df)
    f_units, r_units = extract_units(headers)

    f_count = length(f_units)
    r_count = length(r_units)

    if f_count + r_count != length(headers)
        error("Mismatch in total header parsing.")
    end

    # Build the implementations section
    implementations = build_implementations(df, f_count, f_units, r_units;
        f_mode = f_mode, r_mode = r_mode)

    # Assemble YAML structure
    data = Dict(
        "F" => f_units,
        "R" => r_units,
        "implementations" => implementations
    )

    YAML.write_file(saveFilePath, data)
    println("YAML successfully saved at $saveFilePath")
    return data
end

function build_headers(F_variables, F_units, R_variables, R_units)
    f_headers = ["F_$(name)_$(unit)" for (name, unit) in zip(F_variables, F_units)]
    r_headers = ["R_$(name)_$(unit)" for (name, unit) in zip(R_variables, R_units)]
    return vcat(f_headers, r_headers)
end
