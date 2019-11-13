umaCorrotina = coroutine.create(function () print("opa") end)

print(coroutine.status(umaCorrotina))

print(coroutine.resume(umaCorrotina))

co = coroutine.create(
    function ()
        for i=1,3 do
            print("co", i)
            print(coroutine.status(co))
            coroutine.yield()
        end
    end
)

print(coroutine.resume(co))

co2 = coroutine.create(
    function (a, b)
        print("estou em co2, a, b")
        coroutine.yield(a + b, a - b)
        print("ainda ha o que fazer")
    end
)

print(coroutine.resume(co2, 20, 10))