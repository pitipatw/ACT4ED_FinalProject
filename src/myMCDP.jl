module myMCDP

using CSV, DataFrames

export convert_csv_to_yaml, build_headers,
    extract_result, load_results

include("yaml_generator.jl")
include("post_processing.jl")
end
