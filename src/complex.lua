Complex = {}
Complex.mt = {}

function Complex.new(x, y)
    local comp = setmetatable({}, Complex.mt)
    comp.a = x
    comp.b = y
    return comp
end

Complex.add = function(x, y)
    return Complex.new(x.a + y.a, x.b + y.b)
end

Complex.mult = function(x, y)
    return Complex.new(x.a*y.a - x.b*y.b, x.a*y.b + x.b*y.a)
end

function Complex.abs(c)
    return math.sqrt(c.a^2 + c.b^2)
end

function Complex.mt.__tostring(self)
    return (self.a .. ' + ' .. self.b .. 'i')
end
