function fibsAux(x)
    if(x < 2) then
        return x
    end
    return fibsAux(x-1) + fibsAux(x-2)
end

function fibs(x)
    vetor = {}
    for i = 1, x do
        table.insert(vetor, fibsAux(i))
    end
    return pairs(vetor)
end


s = 0
for key,i in fibs(6) do
    s = s + i
end
print (s) -- 12