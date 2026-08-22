-- Text overlay configuration
swayimg.text.font = "CaskaydiaCove Nerd Font"
swayimg.text.size = 17

swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.viewer.on_key("g", function() swayimg.mode = "gallery" end)
swayimg.viewer.on_key("s", function() swayimg.mode = "slideshow" end)
swayimg.viewer.on_key("h", function() swayimg.viewer.open "prev" end)
swayimg.viewer.on_key("l", function() swayimg.viewer.open "next" end)

swayimg.slideshow.on_key("v", function() swayimg.mode = "viewer" end)
swayimg.slideshow.on_key("g", function() swayimg.mode = "gallery" end)
swayimg.slideshow.on_key("q", function() swayimg.exit() end)

swayimg.gallery.on_key("Return", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("v", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.select "left" end)
swayimg.gallery.on_key("j", function() swayimg.gallery.select "down" end)
swayimg.gallery.on_key("k", function() swayimg.gallery.select "up" end)
swayimg.gallery.on_key("l", function() swayimg.gallery.select "right" end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

-- This allows to delete an image in every possible mode.
swayimg.gallery.on_key("d", function() DeleteImage("gallery") end)
swayimg.slideshow.on_key("d", function() DeleteImage("slideshow") end)
swayimg.viewer.on_key("d", function() DeleteImage("viewer") end)

-- Sets the current image as wallpaper.
swayimg.gallery.on_key("w", function() SetAsWallpaper("gallery") end)
swayimg.slideshow.on_key("w", function() SetAsWallpaper("slideshow") end)
swayimg.viewer.on_key("w", function() SetAsWallpaper("viewer") end)

function GetImage(mode)
    local image

    if mode == "slideshow" then
        image = swayimg.slideshow.get_image()
    elseif mode == "gallery" then
        image = swayimg.gallery.get_image()
    elseif mode == "viewer" then
        image = swayimg.viewer.get_image()
    else
        error("Invalid mode: %s", mode)
    end

    return image
end

function DeleteImage(mode)
    local image = GetImage(mode)
    os.remove(image.path)
    swayimg.text.set_status("File " .. image.path .. " removed")
end

function SetAsWallpaper(mode)
    local image = GetImage(mode)
    os.execute("~/.local/bin/set-wallpaper " .. image.path)
    swayimg.text.set_status("File " .. image.path .. " set as wallpaper")
end
