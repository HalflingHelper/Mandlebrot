--Main file to combine all the other files and interface the the Love2d API
--Import actual mandlebrot file
require 'mandlebrot'

--Maybe do something with coroutines to slowly increment number of iterations across the whole image
MAX_ITERATIONS = 100
--Defines the point at which a series is considered to have diverged
THRESHHOLD = 2

RENDER_WIDTH, RENDER_HEIGHT = 512, 512

--The bounds of the graph in complex space, this is a good initial viewing window for the mandlebrot set
--{xmin, xmax, ymin, ymax}
GRAPH_BOUNDS = { -2.25, 1.75, -2, 2 }

--The amount by which the zoom increases on each click
ZOOM_FACTOR = 2

function love.load()
    love.window.setMode(RENDER_WIDTH, RENDER_HEIGHT)
    image_data = love.image.newImageData(RENDER_WIDTH, RENDER_HEIGHT)
    image = love.graphics.newImage(image_data)

    --Generate initial image
    update_image_data()
end

function love.draw()
    love.graphics.draw(image)
end

--Update bounds based on mouse position
function love.mousepressed(x, y, button)
    if button == 1 then
        local center_x = GRAPH_BOUNDS[1] + (x / RENDER_WIDTH) * (GRAPH_BOUNDS[2] - GRAPH_BOUNDS[1])
        local center_y = GRAPH_BOUNDS[3] + (y / RENDER_HEIGHT) * (GRAPH_BOUNDS[4] - GRAPH_BOUNDS[3])

        local new_w = (GRAPH_BOUNDS[2] - GRAPH_BOUNDS[1]) / ZOOM_FACTOR
        local new_h = (GRAPH_BOUNDS[4] - GRAPH_BOUNDS[3]) / ZOOM_FACTOR

        GRAPH_BOUNDS = {
            center_x - new_w / 2,
            center_x + new_w / 2,
            center_y - new_h / 2,
            center_y + new_h / 2
        }
        --Rerender the set
        update_image_data()
    end
end

--Returns an rgb color based on a curve between v and max
--I reallky want this to look better, I need to play with the color curves
function get_color(v, max)
    local x = v / max

    local r = x / 2
    -- local g = math.exp(-5 * (x - .5) ^ 2)
    --Cheaper version of the exponential
    local g = -math.abs(1 * (x - .75)) + 1
    local b = 1 - .5 * x

    return { r, g, b }
end

--Updates image data based on the global params
function update_image_data()
    local cx = GRAPH_BOUNDS[1]
    local cy = GRAPH_BOUNDS[3]
    local dcx = (GRAPH_BOUNDS[2] - GRAPH_BOUNDS[1]) / RENDER_WIDTH
    local dcy = (GRAPH_BOUNDS[4] - GRAPH_BOUNDS[3]) / RENDER_HEIGHT

    for x = 0, RENDER_WIDTH - 1 do
        cx = cx + dcx
        cy = GRAPH_BOUNDS[3]

        for y = 0, RENDER_HEIGHT - 1 do
            cy = cy + dcy
            local d = Eval_Mandlebrot(cx, cy)

            -- image_data:setPixel(x, y, d==-1 and {0, 0, 0} or get_color(d, MAX_ITERATIONS), 1)
            if (d == -1) then
                --It's black
                image_data:setPixel(x, y, 0, 0, 0, 0)
            else
                image_data:setPixel(x, y, get_color(d, MAX_ITERATIONS), 1)
            end
        end
    end
    --Write the image data to the image
    image:replacePixels(image_data)
end
