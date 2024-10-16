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
            dcc_input(type = "text", placeholder = "input"),
            dcc_input(type = "text", placeholder = "input"),
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