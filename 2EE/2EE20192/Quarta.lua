

newpoly = function(fatores)
    qtFatores = #fatores
    novaFuncao = function(x)
        fatores = fatores
        it = qtFatores
        total = 0
        for i=1,it do
            total = total + fatores[i] * (x ^ (it - i))
        end
        return total
    end
    return novaFuncao
end

f = newpoly({3,0,1})
print(f(0))
print(f(5))
print(f(10))