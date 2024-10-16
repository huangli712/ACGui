
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
