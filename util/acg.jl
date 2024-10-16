#!/usr/bin/env julia

using Dash

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        html_h2("ACGui: A Graphic User Interface For ACFlow"),
        html_h4("Developed by Li Huang (hungli@caep.cn)"),
        layout_base_block()
        #layout_maxent_block()
    end
end

function layout_base_block()
    html_table(
        html_tbody([
            html_tr([
                html_th(html_label("finput : ")),
                html_td(dcc_input(type = "text", placeholder = "input")),
            ]), 
        ])
    )
end

function layout_maxent_block()
    html_div(
        children = [
            html_label("finput : "),
            dcc_input(type = "text", placeholder = "input"),
            html_label("solver : "),
            dcc_input(type = "text", placeholder = "input"),
        ],
    )
end

app = dash()
acg_layout!(app)
run_server(app, "0.0.0.0", debug = true)