--Main file to combine all the other files and interface the the Love2d API
require 'mandlebrot'

--Eventually add a slider to handle iterations cap, otherwise we just do this
MAX_ITERATIONS = 20
THRESHHOLD = 2

RENDER_WIDTH, RENDER_HEIGHT = 256, 256

--{xmin, xmax, ymin, ymax}
GRAPH_BOUNDS = { -3, 1, -2, 2 }

ZOOM_FACTOR = 2



function love.load()
    image_data = love.image.newImageData(RENDER_WIDTH, RENDER_HEIGHT, "r8")
    image = love.graphics.newImage(image_data)

    for x = 0, RENDER_WIDTH-1 do
        for y = 0, RENDER_HEIGHT-1 do
            local cx = x/64 - 3
            local cy = y/64 - 2

            local d = Eval_Mandlebrot(cx, cy)

            if (d == -1) then
                --It's black
                image_data:setPixel(x, y, 0, 0, 0, 0)
            else
                image_data:setPixel(x, y, d/MAX_ITERATIONS, d/MAX_ITERATIONS, d/MAX_ITERATIONS, 1)
            end
        end
    end

    image:replacePixels(image_data)
end

function love.draw()
    love.graphics.draw(image)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        --Update bounds based on mouse position
        --Rerender the set
    end
end
