
function newPoly (fatores)
    qtFatores = Table.getn(fatores)
    novaFuncao = function(x)
        it = qtFatores
        fatores = fatores -- Não sei se ele ainda armazenaria os fatores depois de ser retornado
        total = fatores[qtFatores]
        for i=1, (it - 1) do
            total = total + fatores[i] * (x ^ (i-1))
        end
        return total
    end
    return novaFuncao
end
    