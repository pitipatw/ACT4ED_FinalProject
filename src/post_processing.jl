using YAML

function extract_result(result_string)

    # Extract all Decimal('number') occurrences
    matches = collect(eachmatch(r"Decimal\('([0-9\.\-E]+)'\)", result_string))

    # Convert to float
    vals = parse.(Float64, getfield.(matches, :captures) .|> first)
    println(vals)
    # Split into pairs
    xs = vals[1:2:end]
    ys = vals[2:2:end]

    println("xs = ", xs)
    println("ys = ", ys)

    return xs, ys
end

"""
    load_results(path) -> (r_opt, r_pes)

Load YAML file and extract maximals from optimistic and pessimistic sections.
"""
function load_results(path::String)

    data = YAML.load_file(path)

    r_opt = extract_result(data["optimistic"]["minimals"])
    r_pes = extract_result(data["pessimistic"]["minimals"])

    return r_opt, r_pes
end
