# Mandlebrot
I wanted to implement a mandlebrot set. I chose Lua and Love2d, because I like coding in Lua, and Love2d makes graphics less of a headache than something like SDL2 for a quick project like this.

# Running the project
In order to run the project, you will have to download [Love2d](Love2d.org). Once it is installed, use love.exe to open the src file. Alternatively, you can compress `miain.lua`, `mandlebrot.lua` and `conf.lua` into a zip file and change the extension to `.love`, which should allow you to automatically run it with `love.exe`.

At some point I might go ahead and put prebuilt executables in the releases tab.

# Customization options
You can change screen resolution, maximum number of iterations, and the soom factor by modifying the corresponding values at the top of `main.lua`. If you want to explore the julia set, change the function on line 79 of `main.lua` to `Eval_Julia`. You can modify the values of a and b in the definition of `Eval_Julia` to view the julia set at different definitions of c.
