# Installation

It is quite easy to install `ACGui`.

## Prerequisite

Besides the Julia runtime environment, `ACGui` only needs the following packages:

* TOML
* Base64
* Dash
* ACFlow

Here, `TOML` and `Base64` are standard libraries. `Dash` is a web framework, users have to install it manually.

```julia-repl
julia> using Pkg
julia> Pkg.add("Dash")
```

Note that [`ACFlow`](https://github.com/huangli712/ACFlow) is not a registered package, so please follow its user guide to install it.

## How to install

The users can use the `Pkg` package to install the `ACGui` app from its github repository directly:

```julia-repl
julia> using Pkg
julia> Pkg.add(url = "https://github.com/huangli712/ACGui")
```

If the installed `ACGui` app is outdated, the users can use the following commands to upgrade `ACGui`:

```julia-repl
julia> using Pkg
julia> Pkg.update("ACGui")
```

## Documentation

!!! info

    If the users do not want to install `ACGui`, just have a try. The simplest way is as follows:

    * Download the source codes of `ACGui` from its github repository:
    
    ```text
    https://github.com/huangli712/ACGui
    ```

    Then uncompress it into `/home/your_home/acgui`.

    * Plug the following code in front of the `acgui/util/acg.jl` script:
    
    ```julia
    push!(LOAD_PATH, "/home/your_home/acgui/src")
    ```
