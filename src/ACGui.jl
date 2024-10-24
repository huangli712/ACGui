
# Project : Tulip
# Source  : ACGui.jl
# Author  : Li Huang (huangli@caep.cn)
# Status  : Unstable
#
# Last modified: 2024/10/16
#

module ACGui

using Dash
using Base64
using ACFlow

include("layout.jl")
include("callback.jl")
include("base.jl")

export acg_run

end
