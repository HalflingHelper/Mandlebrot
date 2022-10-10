local add = function(x, y)
    return {x[1] + y[1], x[2] + y[2]}
end

local mult = function(x, y)
    return {x[1]*y[1] - x[2]*y[2], x[1]*y[2] + x[2]*y[1]}
end

local abs = function(c)
    return math.sqrt(c[1]^2 + c[2]^2)

end

--Where z and c are complex numbers
local mandlebrot_fn = function(z, c)
    return add(mult(z,z), c)
end

--Evaluates the mandlebrot function at the point x +yi in the complex plane
--Returns the number of iterations until divergence, or -1 if it doesn't diverge
function Eval_Mandlebrot(x, y)
    local c = {x, y}
    local z = {0, 0}
    local i = 0

    while i < MAX_ITERATIONS and abs(z) <= THRESHHOLD do
        z = mandlebrot_fn(z, c)
        i = i + 1
    end

    if abs(z) > THRESHHOLD then
        return i
    end

    return -1
end