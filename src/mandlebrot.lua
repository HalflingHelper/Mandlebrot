require 'complex'

--Where z and c are complex numbers
local add = function(x, y)
    return Complex.new(x.a + y.a, x.b + y.b)
end

local mult = function(x, y)
    return Complex.new(x.a*y.a - x.b*y.b, x.a*y.b + x.b*y.a)
end

local mandlebrot_fn = function(z, c) 
    return add(c, mult(z, z))
end

--Evaluates the mandlebrot function at the point x +yi in the complex plane
--Returns the number of iterations until divergence, or -1 if it doesn't diverge
function Eval_Mandlebrot(x, y)
    local c = Complex.new(x, y)
    local z = Complex.new(0, 0)
    local i = 0

    while i < MAX_ITERATIONS and Complex.abs(z) <= THRESHHOLD do
        z = mandlebrot_fn(z, c)
        i = i + 1
    end

    if Complex.abs(z) > THRESHHOLD then
        return i
    end

    return -1
end