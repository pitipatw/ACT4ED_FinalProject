
using CSV, DataFrames
using Makie, GLMakie

# load the .csv files
concrete_section_catalog = CSV.read("reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1.csv", DataFrame)
concrete_section_catalog_full = CSV.read("reinforced_concrete.mcdplib/concrete_section_catalogues/concrete_section_catalogue_1_full.csv", DataFrame)

rebar_layout_catalog = CSV.read("reinforced_concrete.mcdplib/rebar_layout_catalogues/rebar_layout_catalogue_1.csv", DataFrame)

""" result_1_x
   res_blueprint: ImpUpperSetInc(minimals={⟨40.000537109⟩: ⟨model120,model1761⟩})
   res_blueprint: ImpUpperSetInc(minimals={⟨159.232148437⟩: ⟨model78,model1105⟩})
   res_blueprint: ImpUpperSetInc(minimals={⟨67.346906372⟩: ⟨model123,model1782⟩})
   res_blueprint: ImpUpperSetInc(minimals={⟨256.846306813⟩: ⟨model120,model1767⟩})
"""

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
# retreive design
id_pair_list = [
                (120, 1761),
                (78, 1105),
                (123, 1782),
                (120, 1767)
                ]

carbon_list = [
            40.000537109
            159.232148437
            67.346906372
            256.846306813
                ]

moment_list = [20_000_000, 80_000_000, 40_000_000, 160_000_000]

demand_ratio = []
for i in eachindex(id_pair_list)

    a_pair = id_pair_list[i]
    @show moment_demand = moment_list[i]

    @show concrete_section_id = a_pair[1]
    @show rebar_layout_id = a_pair[2]

    concrete_section = concrete_section_catalog[concrete_section_id + 1, :]
    concrete_section_full = concrete_section_catalog_full[concrete_section_id + 1, :]
    rebar_layout = rebar_layout_catalog[rebar_layout_id + 1, :]

    fc′ = concrete_section_full["F_concrete_strength_N/mm/mm"]
    b = concrete_section_full["F_section_width_mm"]
    a = concrete_section_full["F_compression_depth_mm"]
    d = concrete_section_full["F_section_depth_mm"]
    moment_arm = concrete_section_full["F_moment_arm_mm"]

    # main check starts here
    moment_arm_recalc = d - a / 2
    moment_arm == moment_arm_recalc ? "Moment arm verification passes" : "Moment arm verification fails"
    moment_capacity_concrete = 0.85 * fc′ * b * a * moment_arm

    As = rebar_layout["F_total_rebar_area_mm*mm"]
    moment_arm = rebar_layout["F_moment_arm_mm"]
    fy = 420

    moment_capacity_rebar = As * fy * moment_arm

    # check equilibrium
    0.85 * fc′ * b * a
    As * fy
    a_calc = As * fy / (0.85 * fc′ * b)
    moment_arm = d - a_calc / 2

    moment_capacity_concrete = 0.85 * fc′ * b * a_calc * (d - a_calc / 2)
    moment_capacity_rebar = As * fy * (d - a_calc / 2)

    @show ratio = moment_capacity_concrete / moment_demand
    push!(demand_ratio, ratio)
end

applied_load_list = [10, 10, 20, 20]
element_length_list = [4000, 8000, 4000, 8000]

f1 = Figure(size = (500, 500))
ax1 = Axis(f1[1, 1], title = "batch 1",
        limits = (5, 25, 0, 10000),
        xlabel = "applied_load [N/mm]",
        ylabel = "element_length [mm]")
scatter!(ax1, applied_load_list, element_length_list, markersize = sqrt.(10*carbon_list))

save("Result_1.png", f1)


