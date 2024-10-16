#
# Project : Tulip
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/16
#

function acg_run()
    app = dash()

    acg_layout!(app)

    run_server(app, "0.0.0.0", debug = true)
end
