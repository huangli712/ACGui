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
    html_div(
        children = [
            html_label("[BASE] block"),
            html_br(),
            html_label("finput : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_br(),
            html_label("solver : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("ktype : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("mtype : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("grid : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("mesh : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("ngrid : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("nmesh : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("wmax : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("wmin : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("beta : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("offdiag : "),
            dcc_input(type = "text", placeholder = "input"),
            html_br(),
            html_label("fwrite : "),
            dcc_input(type = "text", placeholder = "input"),
        ],
    )
end

function layout_maxent_block()
    html_div(
        children = [
            dcc_input(type = "text", placeholder = "input"),
            dcc_input(type = "text", placeholder = "input"),
            dcc_input(type = "text", placeholder = "input"),
        ],
    )
end

app = dash()
acg_layout!(app)
run_server(app, "0.0.0.0", debug = true)