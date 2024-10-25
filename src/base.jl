#
# Project : Tulip
# Source  : base.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/25
#

"""
    acg_run()


"""
function acg_run()
    app = dash(
        assets_folder="../src/assets",
        prevent_initial_callbacks = false
    )

    acg_clean()
    acg_layout!(app)
    register_callback(app)

    run_server(
        app, 
        Dash.HTTP.Sockets.localhost,
        8848,
        debug = false
    )
end

"""
    acg_clean()

This function will clean the current directory. It will remove all the
files in the folder. So, please make sure that you are running the app
in a safe directory.
"""
function acg_clean()
    dir = pwd()
    println("[ACGui] The current directory is $dir.")
    println("[ACGui] We should clean this directory.")
    list = readdir(dir)
    for f in list
        rm(f)
        println("[ACGui] Delete $f")
    end
end
