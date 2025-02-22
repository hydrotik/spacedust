-- Space Dust! v0.1
-- by hydrotik
--
-- @hydrotik
--
-- https://github.com/hydrotik
--
--
--
-- ENC 2: TBD
-- ENC 3: TBD
-- ENC 1: TBD
--
-- KEY 2&3: TBD
--
--

engine.name = 'SpaceGranulator' 


m = midi.connect(2)
u = require("util")

-- init() is automatically called by norns
function init()
  message = "SPACEDUST" -- message
  screen_dirty = true -- ensure we only redraw when something changes
  redraw_clock_id = clock.run(redraw_clock) -- create a "redraw_clock" and note the id
end

-- enc() is automatically called by norns
function enc(e, d)
  if e == 1 then turn(e, d) end -- turn encoder 1
  if e == 2 then turn(e, d) end -- turn encoder 2
  if e == 3 then turn(e, d) end -- turn encoder 3
  screen_dirty = true -- something changed
end

-- an encoder has turned
function turn(e, d)
  message = "encoder " .. e .. ", delta " .. d
end

-- key() is automatically called by norns
function key(k, z)
  if z == 0 then return end
  if k == 2 then press_down(2) end -- but press_down(2)
  if k == 3 then press_down(3) end -- and press_down(3)
  screen_dirty = true --  something changed
end

-- a key has been pressed
function press_down(i)
  message = "press down " .. i
end

-- a clock that draws space
function redraw_clock()
  while true do ------------- "while true do" means "do this forever"
    clock.sleep(1/15) ------- pause for a fifteenth of a second (aka 15fps)
    if screen_dirty then ---- only if something changed
      redraw() -------------- redraw space
      screen_dirty = false -- and everything is clean again
    end
  end
end

-- redraw() is automatically called by norns
function redraw()
  screen.clear() --------------- clear space
  screen.aa(1) ----------------- enable anti-aliasing
  screen.font_face(1) ---------- set the font face to "04B_03"
  screen.font_size(8) ---------- set the size to 8
  screen.level(15) ------------- max
  screen.move(64, 32) ---------- move the pointer to x = 64, y = 32
  screen.text_center(message) -- center our message at (64, 32)
  screen.pixel(0, 0) ----------- make a pixel at the north-western most terminus
  screen.pixel(127, 0) --------- and at the north-eastern
  screen.pixel(127, 63) -------- and at the south-eastern
  screen.pixel(0, 63) ---------- and at the south-western
  screen.fill() ---------------- fill the termini and message at once
  screen.update() -------------- update space
end

-- execute r() in the repl to quickly rerun this script
function r()
  norns.script.load(norns.state.script) -- https://github.com/monome/norns/blob/main/lua/core/state.lua
end

-- cleanup() is automatically called on script close
function cleanup()
  clock.cancel(redraw_clock_id) -- melt our clock via the id we noted
end