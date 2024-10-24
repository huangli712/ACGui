#
# Project : Tulip
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/25
#

function acg_run()
    app = dash(assets_folder="../src/assets", prevent_initial_callbacks = true)
    acg_layout!(app)
    register_callback(app)
    run_server(app, "0.0.0.0", debug = true)
end
