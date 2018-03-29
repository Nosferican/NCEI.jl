using Documenter, NCEI

makedocs(
    # format = :html,
    sitename = "NCEI.jl",
    pages = [
        "index.md",
        "GettingStarted.md",
        "Examples.md"
    ]
)

deploydocs(
    deps = Deps.pip("pygments", "mkdocs", "python-markdown-math"),
    repo = "github.com/Nosferican/NCEI.jl.git",
    julia  = "0.7-DEV.4708"
)
