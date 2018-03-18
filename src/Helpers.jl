# Helpers
id_or_chain(obj::AbstractString, kind::AbstractString) = kind * "id=" * obj * "&"
id_or_chain(obj::AbstractVector{<:AbstractString}, kind::AbstractString) = reduce(*, kind .* "id=" .* obj .* "&")

function parse_url(token::AbstractString, url::AbstractString)
    header = [("token", token)]
    response = request("GET", url, header)
    str = String(getfield(response, :body))
    output = parse(str)
    return output
end

function parse_urls(token::AbstractString, url::AbstractString)
    url = url * "&limit=1000&offset=0"
    output = parse_url(token, url)
    if !isempty(output)
        urls = url[1:end - 1] .* string.(collect(1:1000:(output["metadata"]["resultset"]["count"]))[2:end])
        for url ∈ urls
            append!(output["results"], parse_url(token, url)["results"])
        end
    end
    return output
end
