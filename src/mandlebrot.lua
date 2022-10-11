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

--Where z = a + bi and c = x + yi
local man_fn_2 = function(a, b, x, y)
    return (a*a-b*b + x), (2*a*b + y)

end

--Evaluates the mandlebrot function at the point x +yi in the complex plane
--Returns the number of iterations until divergence, or -1 if it doesn't diverge
function Eval_Mandlebrot(x, y)
    --c = {x, y}
    --z = {0, 0}
    local zx, zy = 0, 0
    local i = 0

    while i < MAX_ITERATIONS and abs({zx, zy}) <= THRESHHOLD do
        zx, zy =  man_fn_2(zx, zy, x, y)
        i = i + 1
    end

    if abs({zx, zy}) > THRESHHOLD then
        return i
    end

    return -1
end