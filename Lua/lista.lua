list = nil
for line in io.lines() do
    if line ~= "" then
        list = {next=list, value=line}
    else
        break
    end
end

-- print(list)

local l = list
while l do
    print(l.value)
    l = l.next
end