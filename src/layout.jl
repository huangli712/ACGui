
# Project : Tulip
# Source  : layout.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/25
#

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
                label = "About",
                children = layout_about_block(),
                className = "custom-tab",
            ),
        ]),
        html_br(),
        html_br(),
        html_br()
    end
end

function layout_header_block()
    html_center([
        html_h2("ACGui"),
        html_h3("A Graphic User Interface For ACFlow"),
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