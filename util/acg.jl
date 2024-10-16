#!/usr/bin/env julia

using Dash

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        html_h2("ACGui: A Graphic User Interface For ACFlow"),
        html_h4("Developed by Li Huang (hungli@caep.cn)"),
        layout_base_block(),
        layout_maxent_block()
    end
end

function layout_base_block()
    html_table([
        html_thead(
            html_tr(
                html_th(html_label("Base block"), colSpan = 3)
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
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Type of kernel function")),
                html_td(html_label("ktype")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Type of default model function")),
                html_td(html_label("mtype")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Grid for input data (imaginary axis)")),
                html_td(html_label("grid")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Mesh for output data (real axis)")),
                html_td(html_label("mesh")),
                html_td(dcc_input(type = "text", placeholder = "input")),
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
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Are the analytic continuation results written into files")),
                html_td(html_label("fwrite")),
                html_td(dcc_input(type = "text", placeholder = "input")),
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
                html_th(html_label("Base block"), colSpan = 3)
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
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Type of kernel function")),
                html_td(html_label("ktype")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Type of default model function")),
                html_td(html_label("mtype")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Grid for input data (imaginary axis)")),
                html_td(html_label("grid")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Mesh for output data (real axis)")),
                html_td(html_label("mesh")),
                html_td(dcc_input(type = "text", placeholder = "input")),
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
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Are the analytic continuation results written into files")),
                html_td(html_label("fwrite")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
            html_tr([
                html_th(html_label("Restriction of the energy range of the spectrum")),
                html_td(html_label("exclude")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]),
        ]),
    ])
end

app = dash()
acg_layout!(app)
run_server(app, "0.0.0.0", debug = true)
