content.function receive()
    local status, value = coroutine.resume(producer)
    return value
end

function send (x)
    print("enviando valor")
    coroutine.yield(producer, x)
end

consumer = coroutine.create(
    function ()
        while true do
            local x = receive()
            io.write(x, "\n")
        end
    end)

producer = coroutine.create(
    function ()
        local i = 0
        while true do
            send(i)
            i = i + 1
        end
    end)

coroutine.resume(consumer)