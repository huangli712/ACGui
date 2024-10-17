#!/usr/bin/env julia

using Dash

const BASE_BLOCK = ["finput", "solver", "ktype", "mtype", "grid", "mesh", "ngrid", "nmesh", "wmax", "wmin", "beta", "offdiag", "fwrite", "exclude"]

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        layout_header_block(),
        html_br(),
        layout_base_block(),
        html_br(),
        layout_maxent_block(),
        layout_barrat_block(),
        layout_stochpx_block(),
        html_br(),
        layout_hidden_block()
    end
end

function layout_header_block()
    html_div([
        html_h2("ACGui: A Graphic User Interface For ACFlow"),
        html_hr(),
        html_h4("Version : v0.0.1-devel.241017"),
        html_h4("Release : 2024/10"),
        html_h4("Developed by Li Huang (hungli@caep.cn)"),
    ])
end

function layout_base_block()
    html_table([
        html_thead(
            html_tr(
                html_th(html_label("[Base] block"), colSpan = 3)
            )
        ),
        #
        html_tbody([
            html_tr([
                html_th(html_label("Filename for input data")),
                html_td(html_label("finput")),
                html_td(
                    dcc_input(
                        id = "finput",
                        type = "text",
                        value = "green.data",
                        readOnly = true
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Solver for the analytic continuation problem")),
                html_td(html_label("solver")),
                html_td(
                    dcc_dropdown(
                        id = "solver",
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
                        id = "ktype",
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
                        id = "mtype",
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
                        id = "grid",
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
                        id = "mesh",
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
                        id = "ngrid",
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
                        id = "nmesh",
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
                        id = "wmax",
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
                        id = "wmin",
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
                        id = "beta",
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
                html_th(html_label("Restriction of the energy range of the spectrum")),
                html_td(html_label("exclude")),
                html_td(
                    dcc_input(
                        id = "exclude",
                        type = "text",
                        value = ""
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
                html_td(dcc_input(type = "text", value = "12")),
            ]),
            html_tr([
                html_th(html_label("Starting value for the α parameter")),
                html_td(html_label("alpha")),
                html_td(dcc_input(type = "text", value = "1e9")),
            ]),
            html_tr([
                html_th(html_label("Scaling factor for the α parameter")),
                html_td(html_label("ratio")),
                html_td(dcc_input(type = "text", value = "10.0")),
            ]),
            html_tr([
                html_th(html_label("Shall we preblur the kernel and spectrum")),
                html_td(html_label("blur")),
                html_td(dcc_input(type = "text", value = "-1.0")),
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
                html_td(dcc_input(type = "text", value = "1e-10")),
            ]),
            html_tr([
                html_th(html_label("Cutoff for unphysical poles")),
                html_td(html_label("pcut")),
                html_td(dcc_input(type = "text", value = "1e-3")),
            ]),
            html_tr([
                html_th(html_label("Tiny distance from the real axis")),
                html_td(html_label("eta")),
                html_td(dcc_input(type = "text", value = "1e-2")),
            ]),
        ]),
    ], id = "barrat-block", hidden = true)
end

function layout_stochpx_block()
end

function layout_hidden_block()
    html_label(children = "me", id = "base")
end

app = dash()
acg_layout!(app)

callback!(
    app,
    Output("maxent-block", "hidden"),
    Output("barrat-block", "hidden"),
    Input("solver", "value"),
) do solver
    println(solver)
    if solver == "MaxEnt"
        return (false, true)
    end

    if solver == "BarRat"
        return (true, false)
    end
end

run_server(app, "0.0.0.0", debug = true)
