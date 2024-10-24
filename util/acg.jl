#!/usr/bin/env julia

push!(LOAD_PATH,"/Users/lihuang/Working/devel/ACFlow/src")
using ACFlow
using Dash
using Base64
using DelimitedFiles

const PBASE = ["finput", "solver", "ktype", "mtype", "grid", "mesh", "ngrid", "nmesh", "wmax", "wmin", "beta", "offdiag", "fwrite"]
const PMaxEnt = ["method", "stype", "nalph", "alpha", "ratio", "blur"]
const PBarRat = ["atype", "denoise", "epsilon", "pcut", "eta"]
const PStochPX = ["method", "nfine", "npole", "ntry", "nstep", "theta", "eta"]

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        layout_header_block(),
        html_br(),
        dcc_tabs(children = [
            dcc_tab(
                label = "Data",
                children = layout_data_block(),
                className = "custom-tab",
            ),
            dcc_tab(
                label = "General",
                children = layout_base_block(),
                className = "custom-tab",
            ),
            dcc_tab(
                label = "Solver",
                children = [
                    layout_maxent_block(),
                    layout_barrat_block(),
                    layout_stochpx_block(),
                ],
                className = "custom-tab",
            ),
            dcc_tab(
                label = "Run",
                children = layout_calc_block(),
                className = "custom-tab",
            ),
            dcc_tab(
                label = "Guide",
                children = [],
                className = "custom-tab",
            ),
        ]),
        html_br(),
        html_br(),
        html_br(),
        html_br()
    end
end

function layout_header_block()
    html_div([
        html_h2("ACGui: A Graphic User Interface For ACFlow"),
        html_hr(),
        html_h4("Version : v0.2.0-devel.241024"),
        html_h4("Release : 2024/10"),
        html_h4("Developed by Li Huang (hungli@caep.cn)"),
    ])
end

function layout_data_block()
    html_div([
        html_br(),
        html_table([
            html_caption(
                html_b("Basic Information About the Uploaded File")
            ),
            html_thead(
                html_tr([
                    html_th("Filename"),
                    html_th("Type"),
                    html_th("Number of rows"),
                    html_th("Number of columns"),
                ])
            ),
            #
            html_tbody(
                html_tr([
                    html_td("N/A", id = "upload-file-name"),
                    html_td("N/A", id = "upload-file-type"),
                    html_td("N/A", id = "upload-file-nrow"),
                    html_td("N/A", id = "upload-file-ncol"),
                ])
            ),
        ]),
        html_br(),
        html_div(id = "upload-file-head"),
        html_br(),
        html_div(id = "upload-file-tail"),
        html_br(),
        html_center(
            dcc_upload(
                children = html_div([
                    "Drag and Drop or ", 
                    html_a("Select Files"),
                ]),
                id = "upload-data",
                multiple = false,
                className = "custom-upload",
            )
        ),
    ])
end

function layout_base_block()
    html_table([
        html_thead(
            html_tr(
                html_th(
                    html_label("Configuration parameters: general setup"),
                    colSpan = 3
                )
            )
        ),
        #
        html_tbody([
            html_tr([
                html_th(html_label("Filename for input data")),
                html_td(html_label("finput")),
                html_td(
                    dcc_input(
                        id = "base-finput",
                        type = "text",
                        value = "giw.data",
                        readOnly = true
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Solver for the analytic continuation problem")),
                html_td(html_label("solver")),
                html_td(
                    dcc_dropdown(
                        id = "base-solver",
                        options = [
                            (label = "MaxEnt", value = "MaxEnt"),
                            (label = "BarRat", value = "BarRat"),
                            (label = "StochPX", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Type of kernel function")),
                html_td(html_label("ktype")),
                html_td(
                    dcc_dropdown(
                        id = "base-ktype",
                        options = [
                            (label = "fermi", value = "fermi"),
                            (label = "boson", value = "boson"),
                            (label = "bsymm", value = "bsymm"),
                        ],
                        value = "fermi",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Type of default model function")),
                html_td(html_label("mtype")),
                html_td(
                    dcc_dropdown(
                        id = "base-mtype",
                        options = [
                            (label = "flat", value = "flat"),
                            (label = "gauss", value = "gauss"),
                            (label = "1gauss", value = "1gauss"),
                            (label = "2gauss", value = "2gauss"),
                            (label = "lorentz", value = "lorentz"),
                            (label = "1lorentz", value = "1lorentz"),
                            (label = "2lorentz", value = "2lorentz"),
                            (label = "risedecay", value = "risedecay"),
                        ],
                        value = "flat",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Grid for input data (imaginary axis)")),
                html_td(html_label("grid")),
                html_td(
                    dcc_dropdown(
                        id = "base-grid",
                        options = [
                            (label = "ftime", value = "ftime"),
                            (label = "fpart", value = "fpart"),
                            (label = "btime", value = "btime"),
                            (label = "bpart", value = "bpart"),
                            (label = "ffreq", value = "ffreq"),
                            (label = "ffrag", value = "ffrag"),
                            (label = "bfreq", value = "bfreq"),
                            (label = "bfrag", value = "bfrag"),
                        ],
                        value = "ftime",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Mesh for output data (real axis)")),
                html_td(html_label("mesh")),
                html_td(
                    dcc_dropdown(
                        id = "base-mesh",
                        options = [
                            (label = "linear", value = "linear"),
                            (label = "tangent", value = "tangent"),
                            (label = "lorentz", value = "lorentz"),
                            (label = "halflorentz", value = "halflorentz"),
                        ],
                        value = "linear",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of grid points")),
                html_td(html_label("ngrid")),
                html_td(
                    dcc_input(
                        id = "base-ngrid",
                        type = "text",
                        value = "10"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of mesh points")),
                html_td(html_label("nmesh")),
                html_td(
                    dcc_input(
                        id = "base-nmesh",
                        type = "text",
                        value = "501"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Right boundary (maximum value) of output mesh")),
                html_td(html_label("wmax")),
                html_td(
                    dcc_input(
                        id = "base-wmax",
                        type = "text",
                        value = "5.0"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Left boundary (minimum value) of output mesh")),
                html_td(html_label("wmin")),
                html_td(
                    dcc_input(
                        id = "base-wmin",
                        type = "text",
                        value = "-5.0"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Inverse temperature")),
                html_td(html_label("beta")),
                html_td(
                    dcc_input(
                        id = "base-beta",
                        type = "text",
                        value = "10.0"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Is it the offdiagonal part in matrix-valued function")),
                html_td(html_label("offdiag")),
                html_td(
                    dcc_radioitems(
                        id = "base-offdiag",
                        options = [
                            (label = "Yes", value = "true"),
                            (label = "No", value = "false"),
                        ],
                        value = "false",
                        labelStyle = Dict("display" => "inline-block")
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Are the analytic continuation results written into files")),
                html_td(html_label("fwrite")),
                html_td(
                    dcc_radioitems(
                        id = "base-fwrite",
                        options = [
                            (label = "Yes", value = "true"),
                            (label = "No", value = "false"),
                        ],
                        value = "false",
                        labelStyle = Dict("display" => "inline-block")
                    )
                ),
            ]),
        ]),
    ])
end

function layout_maxent_block()
    html_table([
        html_thead(
            html_tr(
                html_th(html_label("[MaxEnt] block"), colSpan = 3)
            )
        ),
        #
        html_tbody([
            html_tr([
                html_th(html_label("How to determine the optimized α parameter")),
                html_td(html_label("method")),
                html_td(
                    dcc_dropdown(
                        id = "maxent-method",
                        options = [
                            (label = "historic", value = "historic"),
                            (label = "classic", value = "classic"),
                            (label = "bryan", value = "bryan"),
                            (label = "chi2kink", value = "chi2kink"),
                        ],
                        value = "chi2kink",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Type of the entropy term")),
                html_td(html_label("stype")),
                html_td(
                    dcc_dropdown(
                        id = "maxent-stype",
                        options = [
                            (label = "sj", value = "sj"),
                            (label = "br", value = "br"),
                        ],
                        value = "sj",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Total number of the chosen α parameters")),
                html_td(html_label("nalph")),
                html_td(
                    dcc_input(
                        id = "maxent-nalph",
                        type = "text",
                        value = "12"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Starting value for the α parameter")),
                html_td(html_label("alpha")),
                html_td(
                    dcc_input(
                        id = "maxent-alpha",
                        type = "text",
                        value = "1e9"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Scaling factor for the α parameter")),
                html_td(html_label("ratio")),
                html_td(
                    dcc_input(
                        id = "maxent-ratio",
                        type = "text",
                        value = "10.0"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Shall we preblur the kernel and spectrum")),
                html_td(html_label("blur")),
                html_td(
                    dcc_input(
                        id = "maxent-blur",
                        type = "text",
                        value = "-1.0"
                    )
                ),
            ]),
        ]),
    ], id = "maxent-block", hidden = true)
end

function layout_barrat_block()
    html_table([
        html_thead(
            html_tr(
                html_th(html_label("[BarRat] block"), colSpan = 3)
            )
        ),
        #
        html_tbody([
            html_tr([
                html_th(html_label("Possible type of the spectrum")),
                html_td(html_label("atype")),
                html_td(
                    dcc_dropdown(
                        id = "barrat-atype",
                        options = [
                            (label = "cont", value = "cont"),
                            (label = "delta", value = "delta"),
                        ],
                        value = "cont",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("How to denoise the input data")),
                html_td(html_label("denoise")),
                html_td(
                    dcc_dropdown(
                        id = "barrat-denoise",
                        options = [
                            (label = "none", value = "none"),
                            (label = "prony_s", value = "prony_s"),
                            (label = "prony_o", value = "prony_o"),
                        ],
                        value = "none",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Threshold for the Prony approximation")),
                html_td(html_label("epsilon")),
                html_td(
                    dcc_input(
                        id = "barrat-epsilon",
                        type = "text",
                        value = "1e-10"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Cutoff for unphysical poles")),
                html_td(html_label("pcut")),
                html_td(
                    dcc_input(
                        id = "barrat-pcut",
                        type = "text",
                        value = "1e-3"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Tiny distance from the real axis")),
                html_td(html_label("eta")),
                html_td(
                    dcc_input(
                        id = "barrat-eta",
                        type = "text",
                        value = "1e-2"
                    )
                ),
            ]),
        ]),
    ], id = "barrat-block", hidden = true)
end

function layout_stochpx_block()
    html_table([
        html_thead(
            html_tr(
                html_th(html_label("[StochPX] block"), colSpan = 3)
            )
        ),
        #
        html_tbody([
            html_tr([
                html_th(html_label("How to evaluate the final spectral density")),
                html_td(html_label("method")),
                html_td(
                    dcc_dropdown(
                        id = "stochpx-method",
                        options = [
                            (label = "best", value = "best"),
                            (label = "mean", value = "mean"),
                        ],
                        value = "mean",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of points of a very fine linear mesh")),
                html_td(html_label("nfine")),
                html_td(
                    dcc_input(
                        id = "stochpx-nfine",
                        type = "text",
                        value = "100000"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of poles")),
                html_td(html_label("npole")),
                html_td(
                    dcc_input(
                        id = "stochpx-npole",
                        type = "text",
                        value = "200"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of attempts (tries) to seek the solution")),
                html_td(html_label("ntry")),
                html_td(
                    dcc_input(
                        id = "stochpx-ntry",
                        type = "text",
                        value = "1000"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of Monte Carlo steps per attempt / try")),
                html_td(html_label("nstep")),
                html_td(
                    dcc_input(
                        id = "stochpx-nstep",
                        type = "text",
                        value = "1000000"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Artificial inverse temperature")),
                html_td(html_label("theta")),
                html_td(
                    dcc_input(
                        id = "stochpx-theta",
                        type = "text",
                        value = "1e+6"
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Tiny distance from the real axis")),
                html_td(html_label("eta")),
                html_td(
                    dcc_input(
                        id = "stochpx-eta",
                        type = "text",
                        value = "1e-4"
                    )
                ),
            ]),
        ]),
    ], id = "stochpx-block", hidden = true)
end

function layout_calc_block()
    html_div([
        html_br(),
        html_label(
            children = "N/A",
            id = "dict-base",
            hidden = true
        ),
        html_label(
            children = "N/A",
            id = "dict-maxent",
            hidden = true
        ),
        html_label(
            children = "N/A",
            id = "dict-barrat",
            hidden = true
        ),
        html_br(),
        html_center(
            html_button(
                children = "Start Analytic Continuation",
                id = "calc",
                n_clicks = 0
            )
        ),
        html_br(),
        html_center(
            html_button(
                children = "Check err.out",
                id = "check-err-out",
                n_clicks = 0
            )
        ),
        html_br(),
        html_div(id = "err-out", hidden = true),
        html_br(),
        html_div(id = "canvas"),
    ])
end

function register_callback(app::Dash.DashApp)
    callback!(
        app,
        Output("err-out", "hidden"),
        Output("err-out", "children"),
        Input("check-err-out", "n_clicks"),
    ) do btn
        fn = "./err.out"
        if isfile(fn)
            err = read(fn, String)
        else
            err = "N/A"
        end
        #
        if iseven(btn)
            return(true, err)
        else
            return(false, err)
        end
    end

    # For upload data
    callback!(
        app,
        Output("upload-file-name", "children"),
        Output("upload-file-type", "children"),
        Output("upload-file-nrow", "children"),
        Output("upload-file-ncol", "children"),
        Output("upload-file-head", "children"),
        Output("upload-file-tail", "children"),
        Input("upload-data", "contents"),
        State("upload-data", "filename"),
    ) do contents, filename
        if !isnothing(filename)
            content_type, content_string = split(contents, ',')
            decoded = base64decode(content_string)
            str = String(decoded)
            #
            #open(filename, "w") do f
            #    write(f, str)
            #end
            #
            str_vec = split(str, "\n", keepempty = false)
            str_head = [split(x, " ", keepempty = false) for x in str_vec[1:4]]
            str_tail = [split(x, " ", keepempty = false) for x in str_vec[end-3:end]]
            nrow = length(str_vec)
            ncol = length(str_head[1])

            dt_head = dash_datatable(
                columns = [Dict("name" => "Column $i", "id" => "column-$i") for i in 1:ncol],
                data = [Dict("column-$i" => str_head[j][i] for i in 1:ncol) for j = 1:4]
            )

            dt_tail = dash_datatable(
                columns = [Dict("name" => "Column $i", "id" => "column-$i") for i in 1:ncol],
                data = [Dict("column-$i" => str_tail[j][i] for i in 1:ncol) for j = 1:4]
            )

            return (filename, content_type, nrow, ncol, dt_head, dt_tail)
        else
            dt = dash_datatable()
            return ("N/A", "N/A", "N/A", "N/A", dt, dt)
        end
    end

    # For enable or disable solver tabs
    callback!(
        app,
        Output("maxent-block", "hidden"),
        Output("barrat-block", "hidden"),
        Output("stochpx-block", "hidden"),
        Input("base-solver", "value"),
    ) do solver
        if solver == "MaxEnt"
            return (false, true, true)
        end
    
        if solver == "BarRat"
            return (true, false, true)
        end

        if solver == "StochPX"
            return (true, true, false)
        end
    end

    callback!(
        app,
        Output("dict-base", "children"),
        [Input("base-$i", "value") for i in PBASE],
    ) do vals...
        return join(vals, "|")
    end

    callback!(
        app,
        Output("dict-maxent", "children"),
        [Input("maxent-$i", "value") for i in PMaxEnt],
    ) do vals...
        return join(vals, "|")
    end

    callback!(
        app,
        Output("dict-barrat", "children"),
        [Input("barrat-$i", "value") for i in PBarRat],
    ) do vals...
        return join(vals, "|")
    end

    callback!(
        app,
        Output("canvas", "children"),
        Input("calc", "n_clicks"),
        State("dict-base", "children"),
        State("dict-maxent", "children"),
        State("dict-barrat", "children"),
    ) do btn, pbase, pmaxent, pbarrat

        if btn > 0
            array_base = split(pbase,"|")
            B = Dict{String,Any}(
                "finput" => string(array_base[1]),
                "solver" => string(array_base[2]),
                "ktype"  => string(array_base[3]),
                "mtype"  => string(array_base[4]),
                "grid"   => string(array_base[5]),
                "mesh"   => string(array_base[6]),
                "ngrid"  => parse(I64, array_base[7]),
                "nmesh"  => parse(I64, array_base[8]),
                "wmax"   => parse(F64, array_base[9]),
                "wmin"   => parse(F64, array_base[10]),
                "beta"   => parse(F64, array_base[11]),
                "offdiag" => parse(Bool, array_base[12]),
                "fwrite"  => parse(Bool, array_base[13]),
            )

            if array_base[2] == "MaxEnt"
                array_maxent = split(pmaxent,"|")
                S = Dict{String,Any}(
                    "method" => string(array_maxent[1]),
                    "stype"  => string(array_maxent[2]),
                    "nalph"  => parse(I64, array_maxent[3]),
                    "alpha"  => parse(F64, array_maxent[4]),
                    "ratio"  => parse(F64, array_maxent[5]),
                    "blur"   => parse(F64, array_maxent[6]),
                )
            end

            if array_base[2] == "BarRat"
                array_barrat = split(pbarrat,"|")
                S = Dict{String,Any}(
                    "atype"   => string(array_barrat[1]),
                    "denoise" => string(array_barrat[2]),
                    "epsilon" => parse(F64, array_barrat[3]),
                    "pcut"    => parse(F64, array_barrat[4]),
                    "eta"     => parse(F64, array_barrat[5]),
                )
            end

            @show B
            @show S
            welcome()
            setup_param(B,S)
            mesh, Aout, Gout = ACFlow.solve(ACFlow.read_data())

            fig = dcc_graph(
                figure = (
                    data = [(x = mesh, y = Aout),],
                )
            )
            return fig
        else
            return dcc_graph()
        end
    end
end

app = dash()
acg_layout!(app)
register_callback(app)
run_server(app, "0.0.0.0", debug = true)
