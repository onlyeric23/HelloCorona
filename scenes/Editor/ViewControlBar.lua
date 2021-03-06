local widget = require("widget")

local MarginGroup = require("ui.MarginGroup")
local GridContainer = require("ui.GridContainer")

local GameConfig = require("GameConfig")

local ControlBar = {}

ControlBar.new = function(width, height, options)
	local upCallback = options and options.upCallback or nil
	local downCallback = options and options.downCallback or nil
	local defaultCallback = options and options.defaultCallback or nil
	local leftCallback = options and options.leftCallback or nil
	local rightCallback = options and options.rightCallback or nil

	local marginSize = options and options.marginSize or 0
	local marginColor = options and options.marginColor or 0

	local bar = MarginGroup.new(
		width,
		height,
		{
			marginSize = marginSize,
			marginColor = marginColor
		}
	)

	local container = GridContainer.new({
		maxW = width-2*marginSize,
		maxH = height-2*marginSize,
		rows = 1,
		cols = 5,
		gapSize = 2
	})

	bar.btnLeft = widget.newButton({
		label="Left",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		fontSize = GameConfig.fontSize,
		onEvent = function(event)
			if event.phase == "ended" and leftCallback then
				leftCallback()
			end
		end,
		shape = "rect",
		width = container.gridW,
		height = container.gridH,
		fillColor = { default=GameConfig.backgroundColor, over={1,1,1,0.1} },
	})
	bar.btnRight = widget.newButton({
		label="Right",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		fontSize = GameConfig.fontSize,
		onEvent = function(event)
			if event.phase == "ended" and rightCallback then
				rightCallback()
			end
		end,
		shape = "rect",
		width = container.gridW,
		height = container.gridH,
		fillColor = { default=GameConfig.backgroundColor, over={1,1,1,0.1} },
	})
	bar.btnUp = widget.newButton({
		label="Up",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		fontSize = GameConfig.fontSize,
		onEvent = function(event)
			if event.phase == "ended" and upCallback then
				upCallback()
			end
		end,
		shape = "rect",
		width = container.gridW,
		height = container.gridH,
		fillColor = { default=GameConfig.backgroundColor, over={1,1,1,0.1} },
	})
	bar.btnDown = widget.newButton({
		label="Down",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		fontSize = GameConfig.fontSize,
		onEvent = function(event)
			if event.phase == "ended" and downCallback then
				downCallback()
			end
		end,
		shape = "rect",
		width = container.gridW,
		height = container.gridH,
		fillColor = { default=GameConfig.backgroundColor, over={1,1,1,0.1} },
	})
	bar.btnDefault = widget.newButton({
		label="Default",
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		fontSize = GameConfig.fontSize,
		onEvent = function(event)
			if event.phase == "ended" and defaultCallback then
				defaultCallback()
			end
		end,
		shape = "rect",
		width = container.gridW,
		height = container.gridH,
		fillColor = { default=GameConfig.backgroundColor, over={1,1,1,0.1} },
	})
	
	container:insertAt(bar.btnLeft, 1, 1)
	container:insertAt(bar.btnDown, 1, 2)
	container:insertAt(bar.btnDefault, 1, 3)
	container:insertAt(bar.btnUp, 1, 4)
	container:insertAt(bar.btnRight, 1, 5)

	bar:insert(container)

	return bar
end


return ControlBar
