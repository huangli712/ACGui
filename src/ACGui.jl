#
# Project : Tulip
# Source  : ACGui.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/26
#

"""
    ACGui

ACGui is a simple web app for the `ACFlow` package. It depends on the Dash
web framework, and provide an useful ui to facilite analytic continuation
calculations. Now ACGui supports three analytic continuation solvers:

* Maximum Entropy Method (`MaxEnt` solver, `recommended`)
* Barycentric Rational Function Method (`BarRat` solver, `recommended`)
* Stochastic Pole eXpansion (`StochPX` solver, `recommended`)

The MaxEnt and BarRat solvers are extremely fast, so users can obtain the
calculated results quickly. However, the StochPX solver is quite slow. It
is not a good idea to start calculations with it through ACGui. In such
cases, users can download the relevant `ac.toml` files from the app, and
then submit tasks manually.
"""
module ACGui

using Dash
using Base64
using TOML
using ACFlow

include("layout.jl")
include("callback.jl")
include("base.jl")

export acg_clean
export acg_run
export acg_layout!
export register_callback

end
