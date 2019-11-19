function f1 (a)
	print("f1", a)
	coroutine.yield(2*a)
	f2(a)
	return a*7
end

function f2 (a)
	print("f2", a)
	return coroutine.yield(3*a)
end

co1 = coroutine.create(function (a,b)
	print("co1", a, b)
	local r = f1(a+1)
	print(r)
	print(a,b)
	local r, s = coroutine.yield(a+b, a-b)
	print("co1", coroutine.resume(co2, a+1,b+1))
	return b, "fim co1"
end)

co2 = coroutine.create(function (a,b)
	print("co2", a, b)
	print("co2", coroutine.resume(co3, a+1, b+1))
	return b, "fim co2"
end)

co3 = coroutine.create(function (a,b)
	print("co3", a, b)
	coroutine.yield(b*57)
	local r, s = coroutine.yield(a+b, a-b)
	print("co3", r, s)
	print("co3", a+1, b+1)
	end)

print("main", coroutine.resume(co1, 6, 14))
print("main", coroutine.resume(co1))
print("main", coroutine.resume(co1, "x", "y"))
print("main", coroutine.resume(co1, "x", "y"))
