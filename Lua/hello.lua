-- l = io.read()
-- n = tonumber(l)
-- if n == nil then 
--     error(l.." is not a valid number") -- .. é o operador de concatenação
-- else
--     print(n*2)
--     print(#l) -- # é o operador de tamanho
-- end

-- rodar com dofile(), passando a string "hello.lua"

a = {}
k = "x"
a[k] = 10
a[20] = "great" value = "value"
print(a["x"])
k = 20
print(a[k])
a["x"] = a["x"] + 1
print(a["x"])