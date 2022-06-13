using TelegraphNoise
using Documenter

DocMeta.setdocmeta!(TelegraphNoise, :DocTestSetup, :(using TelegraphNoise); recursive=true)

makedocs(;
    modules=[TelegraphNoise],
    authors="W. Joe Meese <meese022@umn.edu> and contributors",
    repo="https://github.com/meese-wj/TelegraphNoise.jl/blob/{commit}{path}#{line}",
    sitename="TelegraphNoise.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://meese-wj.github.io/TelegraphNoise.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/meese-wj/TelegraphNoise.jl",
    devbranch="main",
)
