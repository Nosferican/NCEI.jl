using Documenter, NCEI

makedocs(
    format = :html,
    sitename = "NCEI.jl",
    pages = [
        "index.md",
        "GettingStarted.md",
        "Walkthrough.md"
    ]
)

deploydocs(
    julia = "nightly",
    deps = Deps.pip("pygments", "mkdocs"),
    repo = "github.com/Nosferican/NCEI.jl.git",
    target = "build",
    make = nothing
)
