# Mandlebrot
I wanted to implement a mandlebrot set. I chose Lua and Love2d, because I like coding in Lua, and Love2d makes graphics less of a headache than something like SDL2 for a quick project like this.

# Customization options
You can change screen resolution, maximum number of iterations, and the soom factor by modifying the corresponding values at the top of `main.lua`. If you want to explore the julia set, change the function on line 80 of `main.lua` to `Eval_Julia`. You can modify the calues of x and y in the definition of `Eval_Julia` to view the julia set at different definitions of c.