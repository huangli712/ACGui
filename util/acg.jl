#!/usr/bin/env julia

push!(LOAD_PATH, "/Users/lihuang/Working/devel/ACGui/src")
using Dash
using ACGui

app = dash()
acg_layout!(app)
run_server(app, "0.0.0.0", debug = true)