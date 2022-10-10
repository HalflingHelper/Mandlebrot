--Main file to combine all the other files and interface the the Love2d API
require 'mandlebrot'

--Eventually add a slider to handle iterations cap, otherwise we just do this
MAX_ITERATIONS = 40
THRESHHOLD = 2

RENDER_WIDTH, RENDER_HEIGHT = 512, 512

--{xmin, xmax, ymin, ymax}
GRAPH_BOUNDS = { -2.25, 1.75, -2, 2 }

ZOOM_FACTOR = 2



function love.load()
    love.window.setMode(RENDER_WIDTH, RENDER_HEIGHT)
    image_data = love.image.newImageData(RENDER_WIDTH, RENDER_HEIGHT)
    image = love.graphics.newImage(image_data)

    update_image_data()
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

--Returns an rgb color based on a curve between v and max
function determine_color(v, max)
    return {1, 1, 1}
end

--Updates image data based on the global params
function update_image_data()
    local cx = GRAPH_BOUNDS[1]
    local cy = GRAPH_BOUNDS[3]
    local dcx = (GRAPH_BOUNDS[2]-GRAPH_BOUNDS[1])/RENDER_WIDTH
    local dcy = (GRAPH_BOUNDS[4]-GRAPH_BOUNDS[3])/RENDER_HEIGHT

    for x = 0, RENDER_WIDTH-1 do
        cx = cx + dcx
        cy = GRAPH_BOUNDS[3]

        for y = 0, RENDER_HEIGHT-1 do
            cy = cy + dcy
            local d = Eval_Mandlebrot(cx, cy)

            if (d == -1) then
                --It's black
                image_data:setPixel(x, y, 0, 0, 0, 0)
            else
                image_data:setPixel(x, y, determine_color(d, MAX_ITERATIONS), 1)
            end
        end
    end

    image:replacePixels(image_data)
end
