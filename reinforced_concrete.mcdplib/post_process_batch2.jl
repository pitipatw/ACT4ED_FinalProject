
using CSV, DataFrames
using Makie, GLMakie
using GeometryOps

# load the .csv files
concrete_section_catalog = CSV.read("reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1.csv", DataFrame)
concrete_section_catalog_full = CSV.read("reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1_full.csv", DataFrame)

rebar_layout_catalog = CSV.read("reinforced_concrete.mcdplib/rebar_layout_catalogues/rebar_layout_catalogue_1.csv", DataFrame)

""" result_2_x
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[3]
>                 │ │ ⟨13.859435675,4542.375489596⟩: ⟨model167,model2431⟩
>                 │ │ ⟨17.425065732,4051.059228235⟩: ⟨model167,model2431⟩
>                 └ └ ⟨11.023427985,5093.279047780⟩: ⟨model167,model2431⟩

>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[9]
>                 │ │ ⟨10.468033961,4661.318782624⟩: ⟨model167,model2431⟩
>                 │ │ ⟨13.466046908,4109.805839482⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.872785535,4376.884183128⟩: ⟨model167,model2431⟩
>                 │ │ ⟨12.644346041,4241.243235477⟩: ⟨model167,model2431⟩
>                 │ │ ⟨12.644346046,4241.243234543⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.148305794,4516.863121811⟩: ⟨model167,model2431⟩
>                 │ │ ⟨10.468033957,4661.318783651⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.872785530,4376.884184092⟩: ⟨model167,model2431⟩
>                 └ └ ⟨11.148305799,4516.863120816⟩: ⟨model167,model2431⟩


=================

>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[5]
>                 │ │ ⟨23.029895238,4990.140472466⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.494170457,7063.499775361⟩: ⟨model167,model2423⟩
>                 │ │ ⟨18.267839448,5602.929518703⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.490467919,6290.969034793⟩: ⟨model167,model2423⟩
>                 └ └ ⟨29.033322531,4444.371797258⟩: ⟨model167,model2423⟩

>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[33]
>                 │ │ ⟨21.599483650,4589.175639860⟩: ⟨model167,model2423⟩
>                 │ │ ⟨20.281408953,4735.952120281⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.052490000,5903.501522896⟩: ⟨model167,model2423⟩
>                 │ │ ⟨19.043833343,4887.414557713⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.804061110,5543.268685453⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.900714356,5720.550246820⟩: ⟨model167,model2423⟩
>                 │ │ ⟨16.790683261,5205.017327421⟩: ⟨model167,model2423⟩
>                 │ │ ⟨23.003139818,4446.955715602⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.508119745,6287.155155683⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.146514310,6695.729928022⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.508159413,6287.144320153⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.052445010,5903.511697239⟩: ⟨model167,model2423⟩
>                 │ │ ⟨23.003060529,4446.963379673⟩: ⟨model167,model2423⟩
>                 │ │ ⟨21.599409199,4589.183549039⟩: ⟨model167,model2423⟩
>                 │ │ ⟨26.089942516,4175.608789511⟩: ⟨model167,model2423⟩
>                 │ │ ⟨12.255982219,6092.314338897⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.805891989,6488.227256965⟩: ⟨model167,model2423⟩
>                 │ │ ⟨17.881836480,5043.712285260⟩: ⟨model167,model2423⟩
>                 │ │ ⟨27.785509780,4046.198452124⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.805929236,6488.216074900⟩: ⟨model167,model2423⟩
>                 │ │ ⟨26.090032445,4175.601593103⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.900666442,5720.560105858⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.146549284,6695.718388338⟩: ⟨model167,model2423⟩
>                 │ │ ⟨24.497929033,4309.150655848⟩: ⟨model167,model2423⟩
>                 │ │ ⟨20.281478860,4735.943958155⟩: ⟨model167,model2423⟩
>                 │ │ ⟨27.785414006,4046.205425513⟩: ⟨model167,model2423⟩
>                 │ │ ⟨24.498013474,4309.143229289⟩: ⟨model167,model2423⟩
>                 │ │ ⟨15.766058084,5371.490390080⟩: ⟨model167,model2423⟩
>                 │ │ ⟨12.256024464,6092.303839164⟩: ⟨model167,model2423⟩
>                 │ │ ⟨15.766112427,5371.481132642⟩: ⟨model167,model2423⟩
>                 │ │ ⟨17.881774844,5043.720977807⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.804010083,5543.278238956⟩: ⟨model167,model2423⟩
>                 └ └ ⟨16.790625385,5205.026297967⟩: ⟨model167,model2423⟩

====
"""

"""
    parse_blueprint_block(str) -> Vector{(Tuple{Float64,Float64}, Vector{Int})}

Parse MCDP blueprint output lines such as:

    ⟨13.859435675,4542.375489596⟩: ⟨model167,model2431⟩

Returns:
    [
      ((x, y), [167, 2431]),
      ...
    ]
"""
function parse_blueprint_block(str::String)
    results = []

    # regex: match numeric pair and model list
    pattern = r"⟨([0-9.eE+-]+),([0-9.eE+-]+)⟩:\s*⟨([^⟩]+)⟩"

    for m in eachmatch(pattern, str)
        # numeric values
        a = parse(Float64, m.captures[1])
        b = parse(Float64, m.captures[2])

        # split "model167,model2431"
        raw_models = split(strip(m.captures[3]), ",")

        # extract numeric suffix after the word "model"
        model_numbers = [parse(Int, match(r"[0-9]+$", s).match) for s in raw_models]

        push!(results, ((a, b), model_numbers))
    end

    return results
end


function extract_r_opt_and_pes(r_opt, r_pes)

    r_opt_pair = parse_blueprint_block(r_opt)

    r_pes_pair = parse_blueprint_block(r_pes)

    return r_opt_pair, r_pes_pair
end


r1_opt = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[3]
>                 │ │ ⟨13.859435675,4542.375489596⟩: ⟨model167,model2431⟩
>                 │ │ ⟨17.425065732,4051.059228235⟩: ⟨model167,model2431⟩
>                 └ └ ⟨11.023427985,5093.279047780⟩: ⟨model167,model2431⟩
"""

r1_pes = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[9]
>                 │ │ ⟨10.468033961,4661.318782624⟩: ⟨model167,model2431⟩
>                 │ │ ⟨13.466046908,4109.805839482⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.872785535,4376.884183128⟩: ⟨model167,model2431⟩
>                 │ │ ⟨12.644346041,4241.243235477⟩: ⟨model167,model2431⟩
>                 │ │ ⟨12.644346046,4241.243234543⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.148305794,4516.863121811⟩: ⟨model167,model2431⟩
>                 │ │ ⟨10.468033957,4661.318783651⟩: ⟨model167,model2431⟩
>                 │ │ ⟨11.872785530,4376.884184092⟩: ⟨model167,model2431⟩
>                 └ └ ⟨11.148305799,4516.863120816⟩: ⟨model167,model2431⟩
"""
r2_opt = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[5]
>                 │ │ ⟨23.029895238,4990.140472466⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.494170457,7063.499775361⟩: ⟨model167,model2423⟩
>                 │ │ ⟨18.267839448,5602.929518703⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.490467919,6290.969034793⟩: ⟨model167,model2423⟩
>                 └ └ ⟨29.033322531,4444.371797258⟩: ⟨model167,model2423⟩
"""

r2_pes = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[33]
>                 │ │ ⟨21.599483650,4589.175639860⟩: ⟨model167,model2423⟩
>                 │ │ ⟨20.281408953,4735.952120281⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.052490000,5903.501522896⟩: ⟨model167,model2423⟩
>                 │ │ ⟨19.043833343,4887.414557713⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.804061110,5543.268685453⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.900714356,5720.550246820⟩: ⟨model167,model2423⟩
>                 │ │ ⟨16.790683261,5205.017327421⟩: ⟨model167,model2423⟩
>                 │ │ ⟨23.003139818,4446.955715602⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.508119745,6287.155155683⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.146514310,6695.729928022⟩: ⟨model167,model2423⟩
>                 │ │ ⟨11.508159413,6287.144320153⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.052445010,5903.511697239⟩: ⟨model167,model2423⟩
>                 │ │ ⟨23.003060529,4446.963379673⟩: ⟨model167,model2423⟩
>                 │ │ ⟨21.599409199,4589.183549039⟩: ⟨model167,model2423⟩
>                 │ │ ⟨26.089942516,4175.608789511⟩: ⟨model167,model2423⟩
>                 │ │ ⟨12.255982219,6092.314338897⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.805891989,6488.227256965⟩: ⟨model167,model2423⟩
>                 │ │ ⟨17.881836480,5043.712285260⟩: ⟨model167,model2423⟩
>                 │ │ ⟨27.785509780,4046.198452124⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.805929236,6488.216074900⟩: ⟨model167,model2423⟩
>                 │ │ ⟨26.090032445,4175.601593103⟩: ⟨model167,model2423⟩
>                 │ │ ⟨13.900666442,5720.560105858⟩: ⟨model167,model2423⟩
>                 │ │ ⟨10.146549284,6695.718388338⟩: ⟨model167,model2423⟩
>                 │ │ ⟨24.497929033,4309.150655848⟩: ⟨model167,model2423⟩
>                 │ │ ⟨20.281478860,4735.943958155⟩: ⟨model167,model2423⟩
>                 │ │ ⟨27.785414006,4046.205425513⟩: ⟨model167,model2423⟩
>                 │ │ ⟨24.498013474,4309.143229289⟩: ⟨model167,model2423⟩
>                 │ │ ⟨15.766058084,5371.490390080⟩: ⟨model167,model2423⟩
>                 │ │ ⟨12.256024464,6092.303839164⟩: ⟨model167,model2423⟩
>                 │ │ ⟨15.766112427,5371.481132642⟩: ⟨model167,model2423⟩
>                 │ │ ⟨17.881774844,5043.720977807⟩: ⟨model167,model2423⟩
>                 │ │ ⟨14.804010083,5543.278238956⟩: ⟨model167,model2423⟩
>                 └ └ ⟨16.790625385,5205.026297967⟩: ⟨model167,model2423⟩
"""

r3_opt = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[7]
>                 │ │ ⟨16.495641071,6953.229315258⟩: ⟨model167,model2433⟩
>                 │ │ ⟨41.881042474,4363.775603670⟩: ⟨model167,model2433⟩
>                 │ │ ⟨13.067939855,7812.096298838⟩: ⟨model167,model2433⟩
>                 │ │ ⟨20.822423227,6188.786730363⟩: ⟨model167,model2433⟩
>                 │ │ ⟨10.352495626,8777.051038485⟩: ⟨model167,model2433⟩
>                 │ │ ⟨33.178397962,4902.791738450⟩: ⟨model167,model2433⟩
>                 └ └ ⟨26.284113916,5508.387463918⟩: ⟨model167,model2433⟩
"""
r3_pes = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[41]
>                 │ │ ⟨14.443827769,6613.768135130⟩: ⟨model167,model2433⟩
>                 │ │ ⟨30.747322367,4533.007789916⟩: ⟨model167,model2433⟩
>                 │ │ ⟨15.382491854,6408.800743228⟩: ⟨model167,model2433⟩
>                 │ │ ⟨11.228143224,7501.293255396⟩: ⟨model167,model2433⟩
>                 │ │ ⟨23.901893181,5141.312066357⟩: ⟨model167,model2433⟩
>                 │ │ ⟨14.443849141,6613.763242201⟩: ⟨model167,model2433⟩
>                 │ │ ⟨13.562462525,6825.285780773⟩: ⟨model167,model2433⟩
>                 │ │ ⟨25.455172896,4981.981269271⟩: ⟨model167,model2433⟩
>                 │ │ ⟨18.580523408,5831.243058311⟩: ⟨model167,model2433⟩
>                 │ │ ⟨37.139768621,4124.492508323⟩: ⟨model167,model2433⟩
>                 │ │ ⟨22.443394904,5305.738487359⟩: ⟨model167,model2433⟩
>                 │ │ ⟨21.073925663,5475.419446753⟩: ⟨model167,model2433⟩
>                 │ │ ⟨19.787961248,5650.535273963⟩: ⟨model167,model2433⟩
>                 │ │ ⟨10.542984091,7741.200934859⟩: ⟨model167,model2433⟩
>                 │ │ ⟨16.382108621,6210.194687700⟩: ⟨model167,model2433⟩
>                 │ │ ⟨19.787990527,5650.531093643⟩: ⟨model167,model2433⟩
>                 │ │ ⟨27.109393480,4827.588181192⟩: ⟨model167,model2433⟩
>                 │ │ ⟨28.871114639,4677.979781043⟩: ⟨model167,model2433⟩
>                 │ │ ⟨30.747367861,4533.004436353⟩: ⟨model167,model2433⟩
>                 │ │ ⟨34.873492551,4256.399603795⟩: ⟨model167,model2433⟩
>                 │ │ ⟨37.139713668,4124.495559664⟩: ⟨model167,model2433⟩
>                 │ │ ⟨11.228126610,7501.298804929⟩: ⟨model167,model2433⟩
>                 │ │ ⟨12.734897206,7043.562848552⟩: ⟨model167,model2433⟩
>                 │ │ ⟨11.957811245,7268.825936133⟩: ⟨model167,model2433⟩
>                 │ │ ⟨34.873440951,4256.402752723⟩: ⟨model167,model2433⟩
>                 │ │ ⟨18.580495916,5831.247372324⟩: ⟨model167,model2433⟩
>                 │ │ ⟨15.382469094,6408.805484524⟩: ⟨model167,model2433⟩
>                 │ │ ⟨10.542999690,7741.195207845⟩: ⟨model167,model2433⟩
>                 │ │ ⟨32.745456646,4392.528524109⟩: ⟨model167,model2433⟩
>                 │ │ ⟨27.109433591,4827.584609696⟩: ⟨model167,model2433⟩
>                 │ │ ⟨28.871157357,4677.976320229⟩: ⟨model167,model2433⟩
>                 │ │ ⟨25.455210560,4981.977583553⟩: ⟨model167,model2433⟩
>                 │ │ ⟨12.734878363,7043.568059452⟩: ⟨model167,model2433⟩
>                 │ │ ⟨17.446736173,6017.734446830⟩: ⟨model167,model2433⟩
>                 │ │ ⟨23.901928547,5141.308262765⟩: ⟨model167,model2433⟩
>                 │ │ ⟨13.562482592,6825.280731361⟩: ⟨model167,model2433⟩
>                 │ │ ⟨16.382132860,6210.190093338⟩: ⟨model167,model2433⟩
>                 │ │ ⟨17.446710358,6017.738898811⟩: ⟨model167,model2433⟩
>                 │ │ ⟨21.073894482,5475.423497524⟩: ⟨model167,model2433⟩
>                 │ │ ⟨32.745505097,4392.525274474⟩: ⟨model167,model2433⟩
>                 └ └ ⟨11.957793552,7268.831313685⟩: ⟨model167,model2433⟩
"""
r4_opt = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[8]
>                 │ │ ⟨24.473305443,6997.040603853⟩: ⟨model167,model2444⟩
>                 │ │ ⟨39.119427105,5534.322542317⟩: ⟨model167,model2444⟩
>                 │ │ ⟨30.941585097,6222.851399753⟩: ⟨model167,model2444⟩
>                 │ │ ⟨49.458667752,4921.976122331⟩: ⟨model167,model2444⟩
>                 │ │ ⟨19.357207378,7867.547217005⟩: ⟨model167,model2444⟩
>                 │ │ ⟨12.109963866,9946.935132383⟩: ⟨model167,model2444⟩
>                 │ │ ⟨62.530563375,4377.382916076⟩: ⟨model167,model2444⟩
>                 └ └ ⟨15.310619906,8846.354154029⟩: ⟨model167,model2444⟩
""" 
r4_pes = """
>  res_blueprint: ImpLowerSetInc
>                 │ maximals:
>                 │ fdict[57]
>                 │ │ ⟨11.384707253,9123.780147687⟩: ⟨model167,model2444⟩
>                 │ │ ⟨10.690016767,9415.568608842⟩: ⟨model167,model2444⟩
>                 │ │ ⟨12.912479243,8567.042616886⟩: ⟨model167,model2444⟩
>                 │ │ ⟨18.839619899,7092.505435688⟩: ⟨model167,model2444⟩
>                 │ │ ⟨37.657641585,5016.596683466⟩: ⟨model167,model2444⟩
>                 │ │ ⟨24.235214484,6253.343878699⟩: ⟨model167,model2444⟩
>                 │ │ ⟨12.912471252,8567.045267878⟩: ⟨model167,model2444⟩
>                 │ │ ⟨42.711086335,4710.482955777⟩: ⟨model167,model2444⟩
>                 │ │ ⟨12.124549687,8841.031474857⟩: ⟨model167,model2444⟩
>                 │ │ ⟨13.751604910,8301.547406480⟩: ⟨model167,model2444⟩
>                 │ │ ⟨35.359764803,5177.034530385⟩: ⟨model167,model2444⟩
>                 │ │ ⟨48.442675088,4423.048348654⟩: ⟨model167,model2444⟩
>                 │ │ ⟨12.124557190,8841.028739082⟩: ⟨model167,model2444⟩
>                 │ │ ⟨54.943444979,4153.151773289⟩: ⟨model167,model2444⟩
>                 │ │ ⟨10.037709817,9716.691790641⟩: ⟨model167,model2444⟩
>                 │ │ ⟨25.810155295,6059.550883489⟩: ⟨model167,model2444⟩
>                 │ │ ⟨17.690022545,7319.333776328⟩: ⟨model167,model2444⟩
>                 │ │ ⟨16.610563570,7553.418744988⟩: ⟨model167,model2444⟩
>                 │ │ ⟨45.486721567,4564.502269110⟩: ⟨model167,model2444⟩
>                 │ │ ⟨58.513943446,4024.445604260⟩: ⟨model167,model2444⟩
>                 │ │ ⟨33.202104920,5342.603406237⟩: ⟨model167,model2444⟩
>                 │ │ ⟨29.273751806,5689.794122363⟩: ⟨model167,model2444⟩
>                 │ │ ⟨21.367791454,6659.719342932⟩: ⟨model167,model2444⟩
>                 │ │ ⟨40.104872169,4861.129349126⟩: ⟨model167,model2444⟩
>                 │ │ ⟨21.367778230,6659.721403721⟩: ⟨model167,model2444⟩
>                 │ │ ⟨29.273733689,5689.795883017⟩: ⟨model167,model2444⟩
>                 │ │ ⟨15.596993329,7794.985332124⟩: ⟨model167,model2444⟩
>                 │ │ ⟨51.590753107,4285.976758786⟩: ⟨model167,model2444⟩
>                 │ │ ⟨18.839608240,7092.507630399⟩: ⟨model167,model2444⟩
>                 │ │ ⟨11.384714298,9123.777324418⟩: ⟨model167,model2444⟩
>                 │ │ ⟨14.645252629,8044.282461199⟩: ⟨model167,model2444⟩
>                 │ │ ⟨33.202125468,5342.601753018⟩: ⟨model167,model2444⟩
>                 │ │ ⟨14.645261693,8044.279971970⟩: ⟨model167,model2444⟩
>                 │ │ ⟨45.486693417,4564.503681553⟩: ⟨model167,model2444⟩
>                 │ │ ⟨48.442705069,4423.046979983⟩: ⟨model167,model2444⟩
>                 │ │ ⟨17.690011597,7319.336041228⟩: ⟨model167,model2444⟩
>                 │ │ ⟨40.104847349,4861.130853358⟩: ⟨model167,model2444⟩
>                 │ │ ⟨13.751596400,8301.549975317⟩: ⟨model167,model2444⟩
>                 │ │ ⟨22.756376874,6453.334647591⟩: ⟨model167,model2444⟩
>                 │ │ ⟨10.690010151,9415.571522404⟩: ⟨model167,model2444⟩
>                 │ │ ⟨10.037703605,9716.694797383⟩: ⟨model167,model2444⟩
>                 │ │ ⟨31.176105872,5513.467408574⟩: ⟨model167,model2444⟩
>                 │ │ ⟨20.063912151,6872.708699794⟩: ⟨model167,model2444⟩
>                 │ │ ⟨20.063924568,6872.706573098⟩: ⟨model167,model2444⟩
>                 │ │ ⟨31.176125166,5513.465702482⟩: ⟨model167,model2444⟩
>                 │ │ ⟨51.590785036,4285.975432531⟩: ⟨model167,model2444⟩
>                 │ │ ⟨24.235229483,6253.341943660⟩: ⟨model167,model2444⟩
>                 │ │ ⟨42.711112768,4710.481498162⟩: ⟨model167,model2444⟩
>                 │ │ ⟨37.657664890,5016.595131126⟩: ⟨model167,model2444⟩
>                 │ │ ⟨15.596983676,7794.987744211⟩: ⟨model167,model2444⟩
>                 │ │ ⟨54.943410976,4153.153058443⟩: ⟨model167,model2444⟩
>                 │ │ ⟨16.610573850,7553.416407653⟩: ⟨model167,model2444⟩
>                 │ │ ⟨58.513979660,4024.444358933⟩: ⟨model167,model2444⟩
>                 │ │ ⟨22.756390958,6453.332650667⟩: ⟨model167,model2444⟩
>                 │ │ ⟨25.810171268,6059.549008418⟩: ⟨model167,model2444⟩
>                 │ │ ⟨35.359786687,5177.032928400⟩: ⟨model167,model2444⟩
>                 └ └ ⟨27.487444635,5871.763591104⟩: ⟨model167,model2444⟩
"""

r1_opt_pair, r1_pes_pair = extract_r_opt_and_pes(r1_opt, r1_pes)
r2_opt_pair, r2_pes_pair = extract_r_opt_and_pes(r2_opt, r2_pes)
r3_opt_pair, r3_pes_pair = extract_r_opt_and_pes(r3_opt, r3_pes)
r4_opt_pair, r4_pes_pair = extract_r_opt_and_pes(r4_opt, r4_pes)




f2_separated = Figure(size = (1000, 1000))
ax_r1 = Axis(f2_separated[1, 1], title = "Batch 2.1",
xlabel = "applied_load [N/mm]",
ylabel = "element_length [mm]", 
limits = (0, 75, 2000, 10000)
)
scatter!(ax_r1, [i[1][1] for i in r1_opt_pair], [i[1][2] for i in r1_opt_pair], color = :green)
scatter!(ax_r1, [i[1][1] for i in r1_pes_pair], [i[1][2] for i in r1_pes_pair], color = :red)

r1_opt_coord = cat([i[1][1] for i in r1_opt_pair], [i[1][2] for i in r1_opt_pair], dims = 2)
r1_pes_coord = cat([i[1][1] for i in r1_pes_pair], [i[1][2] for i in r1_pes_pair], dims = 2)


function get_convex_hull_points(opt_pair, pes_pair)
    opt_coord = cat([i[1][1] for i in opt_pair], [i[1][2] for i in opt_pair], dims = 2)
    pes_coord = cat([i[1][1] for i in pes_pair], [i[1][2] for i in pes_pair], dims = 2)

    all_coord = cat(opt_coord, pes_coord, dims = 1)
    tup = [tuple(all_coord[i, 1], all_coord[i, 2]) for i in axes(all_coord, 1)]
    points = GeometryOps.convex_hull(tup)
    return points
end
points = get_convex_hull_points(r1_opt_pair, r1_pes_pair)

poly!(ax_r1, points, color = "#3EA8DE")


ax_r2 = Axis(f2_separated[1, 2], title = "Batch 2.2",
xlabel = "applied_load [N/mm]",
ylabel = "element_length [mm]", 
limits = (0, 75, 2000, 10000)
)
scatter!(ax_r2, [i[1][1] for i in r2_opt_pair], [i[1][2] for i in r2_opt_pair], color = :green)
scatter!(ax_r2, [i[1][1] for i in r2_pes_pair], [i[1][2] for i in r2_pes_pair], color = :red)

points_r2 = get_convex_hull_points(r2_opt_pair, r2_pes_pair)
poly!(ax_r2, points_r2, color = "#3EA8DE")

ax_r3 = Axis(f2_separated[2, 1], title = "Batch 2.3",
xlabel = "applied_load [N/mm]",
ylabel = "element_length [mm]",
limits = (0, 75, 2000, 10000)
)
scatter!(ax_r3, [i[1][1] for i in r3_opt_pair], [i[1][2] for i in r3_opt_pair], color = :green)
scatter!(ax_r3, [i[1][1] for i in r3_pes_pair], [i[1][2] for i in r3_pes_pair], color = :red)

points_r3 = get_convex_hull_points(r3_opt_pair, r3_pes_pair)
poly!(ax_r3, points_r3, color = "#3EA8DE")



ax_r4 = Axis(f2_separated[2, 2], title = "Batch 2.4",
xlabel = "applied_load [N/mm]",
ylabel = "element_length [mm]", 
limits = (0, 75, 2000, 10000)
)
scatter!(ax_r4, [i[1][1] for i in r4_opt_pair], [i[1][2] for i in r4_opt_pair], color = :green)
scatter!(ax_r4, [i[1][1] for i in r4_pes_pair], [i[1][2] for i in r4_pes_pair], color = :red)
points_r4 = get_convex_hull_points(r4_opt_pair, r4_pes_pair)
poly!(ax_r4, points_r4, color = "#3EA8DE")


save("Result_2_separated_15122025.png" , f2_separated)
##########

f2_all = Figure(size = (500, 500))
ax_all = Axis(f2_all[1, 1], title = "batch 2 all", 
xlabel = "applied_load [N/mm]",
ylabel = "element_length [mm]"
# limits = (0, 25, 4000, 6000)
)
# s1_opt = scatter!(ax_all, [i[1][1] for i in r1_opt_pair], [i[1][2] for i in r1_opt_pair], color = "#3EA8DE")
s1_pes = scatter!(ax_all, [i[1][1] for i in r1_pes_pair], [i[1][2] for i in r1_pes_pair], color = "#3EA8DE")

# s2_opt = scatter!(ax_all, [i[1][1] for i in r2_opt_pair], [i[1][2] for i in r2_opt_pair], color = "#FF7BAC")
s2_pes = scatter!(ax_all, [i[1][1] for i in r2_pes_pair], [i[1][2] for i in r2_pes_pair], color = "#FF7BAC")

# s3_opt = scatter!(ax_all, [i[1][1] for i in r3_opt_pair], [i[1][2] for i in r3_opt_pair], color = "#58bc81")
s3_pes = scatter!(ax_all, [i[1][1] for i in r3_pes_pair], [i[1][2] for i in r3_pes_pair], color = "#58bc81")

# s4_opt = scatter!(ax_all, [i[1][1] for i in r4_opt_pair], [i[1][2] for i in r4_opt_pair], color = :black)
s4_pes = scatter!(ax_all, [i[1][1] for i in r4_pes_pair], [i[1][2] for i in r4_pes_pair], color = :black)

axislegend(
    ax_all, 
    [s1_pes, s2_pes, s3_pes, s4_pes],
    ["Carbon = 50 kg/mm", "Carbon = 100 kg/mm", "Carbon = 150 kg/mm", "Carbon = 200 kg/mm"],
    halign = :right,
    valign = :top
)

save("Result_2_all_15122025.png" , f2_all)