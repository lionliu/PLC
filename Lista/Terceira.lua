function num_triang(x)
    vetor = {1}
    for i = 2, x do
        table.insert(vetor, i + vetor[i-1])
    end
    return pairs(vetor)
end


for key, x in num_triang(6) do
    io.write(x, "  ")
end
