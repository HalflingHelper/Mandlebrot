function love.conf(t)
    --Disabling unused modules, helps with memory usage, necesary modules are left enables
    t.modules.audio = false     -- Disable  the audio module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.font = false      -- Disable the font module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.joystick = false  -- Disable the joystick module (boolean)
    t.modules.keyboard = false  -- Disable the keyboard module (boolean)
    t.modules.math = true       -- Enable the math module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.physics = false   -- Disable yhe physics module (boolean)
    t.modules.sound = false     -- Disable  the sound module (boolean)
    t.modules.system = false    -- Disable the system module (boolean)
    t.modules.thread = false    -- Disable the thread module (boolean)
    t.modules.timer = false     -- Disable  the timer module (boolean), Disabling it will result 0 delta time in love.update
    t.modules.touch = false     -- Disable  the touch module (boolean)
    t.modules.video = false     -- Disable  the video module (boolean)
end
