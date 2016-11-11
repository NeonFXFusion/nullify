local class = require 'middleclass'
local GUI = {}

local Base = class('GuiBase')

function Base:initialize()

end

function Base:draw()

end

function Base:update()

end

GUI.Base = Base
GUI.Text = Text
GUI.Button = Button
GUI.Panel = Panel
GUI.Checkbox = Checkbox
GUI.List = List
GUI.Slider = Slider
GUI.Input = Input
GUI.Loader = Loader

return GUI
