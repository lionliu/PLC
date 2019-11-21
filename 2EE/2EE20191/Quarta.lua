
function newPoly (fatores)
    qtFatores = #fatores
    novaFuncao = function(x)
        it = qtFatores
        fatores = fatores -- Não sei se ele ainda armazenaria os fatores depois de ser retornado
        total = 0
        for i=1, it  do
            total = total + fatores[i] * (x ^ (it - i))
        end
        return total
    end
    return novaFuncao
end

f = newPoly({3,0,1})
print(f(0))
print(f(5))
print(f(10))