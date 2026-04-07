-- General config
swayimg.set_mode("viewer")
swayimg.enable_antialiasing(true)
swayimg.enable_decoration(true)
swayimg.enable_overlay(false)
swayimg.enable_exif_orientation(true)
swayimg.set_dnd_button("MouseRight")

-- Image list configuration
swayimg.imagelist.set_order("numeric")
swayimg.imagelist.enable_reverse(false)
swayimg.imagelist.enable_recursive(false)
swayimg.imagelist.enable_adjacent(false)
swayimg.imagelist.enable_fsmon(true)

-- Text overlay configuration
swayimg.text.set_font("CaskaydiaMono Nerd Font")
swayimg.text.set_size(15)
swayimg.text.set_spacing(0)
swayimg.text.set_padding(10)
swayimg.text.set_foreground(0xffcccccc)
swayimg.text.set_background(0x00000000)
swayimg.text.set_shadow(0x0d000000)
swayimg.text.set_timeout(5)
swayimg.text.set_status_timeout(3)

-- Image viewer mode
swayimg.viewer.set_default_scale("optimal")
swayimg.viewer.set_default_position("center")
swayimg.viewer.set_drag_button("MouseLeft")
swayimg.viewer.set_window_background(0xff000000)
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c)
swayimg.viewer.enable_centering(true)
swayimg.viewer.enable_loop(true)
swayimg.viewer.limit_preload(1)
swayimg.viewer.limit_history(1)
swayimg.viewer.set_mark_color(0xff808080)
swayimg.viewer.set_text("topleft", {
  "File: {name}",
  "Format: {format}",
  "File size: {sizehr}",
  "File time: {time}",
  "EXIF date: {meta.Exif.Photo.DateTimeOriginal}",
  "EXIF camera: {meta.Exif.Image.Model}"
})
swayimg.viewer.set_text("topright", {
  "Image: {list.index} of {list.total}",
  "Frame: {frame.index} of {frame.total}",
  "Size: {frame.width}x{frame.height}"
})
swayimg.viewer.set_text("bottomleft", {
  "Scale: {scale}"
})

-- Slide show mode, same config as for viewer mode with the following defaults:
swayimg.slideshow.set_timeout(5)
swayimg.slideshow.set_default_scale("fit")
swayimg.slideshow.set_window_background("auto")
swayimg.slideshow.limit_history(0)
swayimg.slideshow.set_text("topleft", { "{name}" })

-- Gallery mode
swayimg.gallery.set_aspect("fill")
swayimg.gallery.set_thumb_size(200)
swayimg.gallery.set_padding_size(5)
swayimg.gallery.set_border_size(5)
swayimg.gallery.set_border_color(0xffaaaaaa)
swayimg.gallery.set_selected_scale(1.15)
swayimg.gallery.set_selected_color(0xff404040)
swayimg.gallery.set_unselected_color(0xff202020)
swayimg.gallery.set_window_color(0xff000000)
swayimg.gallery.limit_cache(100)
swayimg.gallery.enable_preload(false)
swayimg.gallery.enable_pstore(false)
swayimg.gallery.set_text("topleft", {
  "File: {name}"
})
swayimg.gallery.set_text("topright", {
  "{list.index} of {list.total}"
})

swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.viewer.on_key("g", function() swayimg.set_mode("gallery") end)
swayimg.viewer.on_key("s", function() swayimg.set_mode("slideshow") end)

swayimg.slideshow.on_key("v", function() swayimg.set_mode("gallery") end)
swayimg.slideshow.on_key("g", function() swayimg.set_mode("gallery") end)
swayimg.slideshow.on_key("q", function() swayimg.exit() end)

swayimg.gallery.on_key("Return", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("v", function() swayimg.set_mode("viewer") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.switch_image("down") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("l", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

swayimg.on_window_resize(function() swayimg.viewer.set_fix_scale("optimal") end)

swayimg.gallery.on_key("d", function() DeleteImage("gallery") end)
swayimg.slideshow.on_key("d", function() DeleteImage("slideshow") end)
swayimg.viewer.on_key("d", function() DeleteImage("viewer") end)
function DeleteImage(mode)
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
    os.remove(image.path)
    swayimg.text.set_status("File "..image.path.." removed")
end

-- set a custom window title in gallery mode
swayimg.gallery.on_image_change(function()
  local image = swayimg.gallery.get_image()
  swayimg.set_title("Gallery: "..image.path)
end)
