push!(LOAD_PATH, "../src")
push!(LOAD_PATH, "../../ACFlow/src")

using Documenter
using Random
using ACGui

makedocs(
    sitename = "ACGui",
    clean = false,
    authors = "Li Huang <huangli@caep.cn> and contributors",
    format = Documenter.HTML(
        prettyurls = false,
        ansicolor = true,
        repolink = "https://github.com/huangli712/ACGui",
        size_threshold = 409600, # 400kb
    ),
    #format = Documenter.LaTeX(platform = "none"),
    remotes = nothing,
    modules = [ACGui],
    pages = [
        "Home" => "index.md",
        "Installation" => "install.md",
        "Usage" => "usage.md",
        "Library" => "library.md",
    ],
)