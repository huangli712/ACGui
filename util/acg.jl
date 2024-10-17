#!/usr/bin/env julia

using Dash

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        layout_header_block(),
        html_br(),
        layout_base_block(),
        html_br(),
        layout_maxent_block(),
        html_br(),
        layout_barrat_block()
    end
end

function layout_header_block()
    html_div([
        html_h2("ACGui: A Graphic User Interface For ACFlow"),
        html_hr(),
        html_h4("Version : v0.0.1-devel.241017"),
        html_h4("Release : 2024/10"),
        html_h4("Developed by Li Huang (hungli@caep.cn)")
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
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Solver for the analytic continuation problem")),
                html_td(html_label("solver")),
                html_td(
                    dcc_dropdown(
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
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
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Type of default model function")),
                html_td(html_label("mtype")),
                html_td(
                    dcc_dropdown(
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Grid for input data (imaginary axis)")),
                html_td(html_label("grid")),
                html_td(
                    dcc_dropdown(
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Mesh for output data (real axis)")),
                html_td(html_label("mesh")),
                html_td(
                    dcc_dropdown(
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Number of grid points")),
                html_td(html_label("ngrid")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Number of mesh points")),
                html_td(html_label("nmesh")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Right boundary (maximum value) of output mesh")),
                html_td(html_label("wmax")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Left boundary (minimum value) of output mesh")),
                html_td(html_label("wmin")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Inverse temperature")),
                html_td(html_label("beta")),
                html_td(dcc_input(type = "text", placeholder = "input")),
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
                html_td(dcc_input(type = "text", placeholder = "input")),
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
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Type of the entropy term")),
                html_td(html_label("stype")),
                html_td(
                    dcc_dropdown(
                        options = [
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("Total number of the chosen α parameters")),
                html_td(html_label("nalph")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Starting value for the α parameter")),
                html_td(html_label("alpha")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Scaling factor for the α parameter")),
                html_td(html_label("ratio")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Shall we preblur the kernel and spectrum")),
                html_td(html_label("blur")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
        ]),
    ])
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
                            (label = "Maximum entropy method", value = "MaxEnt"),
                            (label = "Barycentric rational function", value = "BarRat"),
                            (label = "Stochastic pole expansion", value = "StochPX"),
                        ],
                        value = "MaxEnt",
                    )
                ),
            ]),
            html_tr([
                html_th(html_label("How to denoise the input data")),
                html_td(html_label("denoise")),
                html_td(
                    html_select([
                        html_option(label = "No denoising", value = "none"),
                        html_option(label = "Prony method (one-shot)", value = "prony_s"),
                        html_option(label = "Prony method (optimized)", value = "prony_o"),
                    ])
                ),
            ]),
            html_tr([
                html_th(html_label("Threshold for the Prony approximation")),
                html_td(html_label("epsilon")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Cutoff for unphysical poles")),
                html_td(html_label("pcut")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Tiny distance from the real axis")),
                html_td(html_label("eta")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
        ]),
    ])
end

app = dash()
acg_layout!(app)
run_server(app, "0.0.0.0", debug = true)
