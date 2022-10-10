--Main file to combine all the other files and interface the the Love2d API
require 'mandlebrot'

--Eventually add a slider to handle iterations cap, otherwise we just do this
MAX_ITERATIONS = 75
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
        local center_x = GRAPH_BOUNDS[1] + (x / RENDER_WIDTH)*(GRAPH_BOUNDS[2]-GRAPH_BOUNDS[1])
        local center_y = GRAPH_BOUNDS[3] + (y / RENDER_HEIGHT)*(GRAPH_BOUNDS[4]-GRAPH_BOUNDS[3])

        local new_w = (GRAPH_BOUNDS[2]-GRAPH_BOUNDS[1])/ZOOM_FACTOR
        local new_h = (GRAPH_BOUNDS[4]-GRAPH_BOUNDS[3])/ZOOM_FACTOR

        GRAPH_BOUNDS = {
            center_x - new_w/2,
            center_x + new_w/2,
            center_y - new_h/2,
            center_y + new_h/2
        }
        --Rerender the set
        update_image_data()
    end
end

--Returns an rgb color based on a curve between v and max
--Calculating for every pixel might be overly slow, maybe try pre-stored color values/curve
function determine_color(v, max)
    local x = v/max

    local r = x
    local g = math.exp(-5*(x-.5)^2)
    local b = 1 - x

    return {r, g, b}
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
