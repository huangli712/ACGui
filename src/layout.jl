
# Project : Tulip
# Source  : layout.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/16
#

function acg_layout!(app::Dash.DashApp)
    app.layout = html_div() do 
        html_h1("ACGui: A Graphic User Interface For ACFlow"),
        html_h2("Develop")
    end
end

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
