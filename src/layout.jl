
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