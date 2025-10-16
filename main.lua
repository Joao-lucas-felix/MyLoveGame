-- This menu works if the screen dimensios are not resizeble

_G.love = require("love")

local BUTTON_WIDTH = 2/3 
local BUTTON_HEIGHT = 0.1
local buttons = {}  -- buttons table

function newButton(text , fn)
    return {
        text=text,
        fn = fn,
        last = false, 
        now = true
    }
end

function love.load()
    font = love.graphics.newFont("fonts/PixelGameFont.ttf",32 )
    table.insert(buttons, newButton("NEW GAME", function() print("New Game Started!") end))
    table.insert(buttons, newButton("EXIT", function() love.event.quit(0) end))
    total_buttons = #buttons
    margin_buttons = 20

    -- Screen dimensions
    sw = love.graphics.getWidth()
    sh = love.graphics.getHeight()

    BUTTON_WIDTH = BUTTON_WIDTH*sw
    BUTTON_HEIGHT = BUTTON_HEIGHT*sh
    button_init = (sw*0.5) - (BUTTON_WIDTH*0.5)
    -- Calcula a altura total dos buttons com base na proporção deles 15%, + a margem.
    total_btn_heigth = total_buttons *( BUTTON_HEIGHT + (margin_buttons))
end


function love.update()
    
end
 function love.draw()

    local cursor_y= 0
    for i,b in ipairs(buttons) do
        
        local by = (sh * 0.5)  - (total_btn_heigth * 0.5 ) + cursor_y

        -- The mous is hover this button 
        hot = love.mouse.getX()  > button_init and love.mouse.getX() < button_init + BUTTON_WIDTH
                and love.mouse.getY() > by and love.mouse.getY() < by + BUTTON_HEIGHT
        if hot then  love.graphics.setColor(1,1,1, 1)
        else love.graphics.setColor(0.5,0.5,0.5, 1) end


   
        love.graphics.rectangle("fill",
                                button_init,            
                                by,                   
                                BUTTON_WIDTH ,         
                                BUTTON_HEIGHT                     
                            )

        textW = font:getWidth(b.text)
        texth = font:getHeight(b.text)

        love.graphics.setColor(0,0,0,1)
        love.graphics.print(b.text, font,
                            sw*0.5 - textW*0.5  ,
                            by + (texth*0.5))


        cursor_y = cursor_y + (BUTTON_HEIGHT + margin_buttons) 
        
        -- Click Logic. 
        b.now = love.mouse.isDown(1)
        if b.now and hot and not b.last then 
    
            b.fn()
        end
    
        b.last = b.now
    end 
    
end