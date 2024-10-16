
# Project : Tulip
# Source  : layout.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/16
#

function acg_layout!(acg::DashApp)
    app.layout = html_dialog() do 
        html_h1("haha haha")
    end
end
