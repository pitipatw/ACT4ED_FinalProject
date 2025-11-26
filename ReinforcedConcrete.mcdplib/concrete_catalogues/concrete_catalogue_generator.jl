using YAML
using CSV
using DataFrames

# create a .csv file with the header 





function build_mcdp_yaml(F_list, R_list, implementations)

    data = Dict(
        "F" => F_list,
        "R" => R_list,
        "implementations" => Dict()
    )

    for (i, impl) in enumerate(implementations)

        model_key = "model$(i-1)"

        # append F units
        f_max_with_unit = [
            string(v, " ", split(F_list[j], "#")[1] |> strip)
            for (j,v) in enumerate(impl[:f_max])
        ]

        # append R units (strip comment after # if exists)
        r_min_with_unit = [
            string(v, " ", split(R_list[j], "#")[1] |> strip)
            for (j,v) in enumerate(impl[:r_min])
        ]

        data["implementations"][model_key] = Dict(
            "f_max" => f_max_with_unit,
            "r_min" => r_min_with_unit
        )
    end

    return YAML.write_file("ReinforcedConcrete.mcdplib/concrete_catalogues/test-output.yml", data)
end

function csv_to_yaml


function generate_concrete_implementation(fc′_list, b_list;
    ratio = [1.0, 1.5, 2.0],
    compression_ratio = [0.1, 0.2, 0.3, 0.4, 0.5]
    )::Vector{Dict{Symbol, Vector{String}}}

    d_list = b_list * ratio' 
    d_list = d_list[:] # flatten

    n = prod(length.([fc′_list, b_list, d_list]))
    implementations = Vector{Dict{Symbol, Vector{String}}}(undef, n)

    counter = 0
    for i_fc′ in eachindex(fc′_list)
        for i_b in eachindex(b_list)
            for i_d in eachindex(d_list)
                for i_compression_ratio in eachindex(compression_ratio)

                    counter += 1
                    fc′_i = fc′_list[i_fc′]
                    b_i = b_list[i_b]
                    d_i = d_list[i_d]
                    compression_ratio_i = compression_ratio[i_compression_ratio]

                    moment_demand = 0.85 * fc′_i * (compression_ratio_i * d_i) * b_i
                    tmp_dict =  Dict(
                            :f_max => [string(moment_demand)],
                            :r_min => string.([fc′_i, b_i, d_i, compression_ratio_i]))

                    implementations[counter] = tmp_dict
                end
            end
        end
    end

    return implementations
end
