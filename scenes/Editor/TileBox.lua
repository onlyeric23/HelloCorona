local widget = require("widget")

local GridContainer = require("ui.GridContainer")

local GameConfig = require("GameConfig")
local TileInfo = require("TileInfo")

local Sprite = require("Sprite")
local isotiles = require("sprites.isotiles")

local TileBox = {}

TileBox.LAYOUT_HORIZONTAL = 0
TileBox.LAYOUT_VERTICAL = 1

TileBox.new = function(maxW, maxH, layout, options)
    local gapSize = options and options.gapSize or 0
    local options = {
        width = maxW,
        height = maxH,
        backgroundColor = {1,1,1,0.3}
    }
    if layout == TileBox.LAYOUT_VERTICAL then
        options["horizontalScrollDisabled"] = true
    elseif layout == TileBox.LAYOUT_HORIZONTAL then
        options["verticalScrollDisabled"] = true
    else
        print("layout is invalid")
        return nil
    end

    local scrollView = widget.newScrollView(options)
    local tiles = {}
    local size = 0
    local selectedTile = nil

    function scrollView:selectTile(idx)
        print("select tile: "..idx)
        self.selectedTile = self.tiles[idx]
    end

    function scrollView:unselectTile()
        self.selectedTile = nil
    end

    -- load isotiles
    for i = 1, #(isotiles.sheet.frames) do
        size = size + 1
        local name = tostring(i)
        tiles[size] = Sprite["isotiles"].new(name)
        tiles[size].xScale = GameConfig.gridWidth / TileInfo.baseWidth
        tiles[size].yScale = GameConfig.gridWidth / TileInfo.baseWidth
        tiles[size].idx = size
        tiles[size].tileBox = scrollView
        tiles[size].touch = function(self, event)
            if ( event.phase == "ended" ) then
                self.tileBox:selectTile(self.idx)
            end
            return true
        end
        tiles[size]:addEventListener( "touch", tiles[size] )
    end

    -- calculate proper layout
    local numCols = nil
    local numRows = nil
    if layout == TileBox.LAYOUT_VERTICAL then
        numCols = math.floor((maxW+gapSize)/(GameConfig.gridWidth + gapSize))
        numRows = math.ceil(size / numCols)
    elseif layout == TileBox.LAYOUT_HORIZONTAL then
        numRows = math.floor((maxH+gapSize)/(GameConfig.gridHeight + gapSize))
        numCols = math.ceil(size / numRows)
    end

    -- use GridContainer for tiles
    local container = GridContainer.new({
        cols = numCols,
        rows = numRows,
        gridW = GameConfig.gridWidth,
        gridH = GameConfig.gridHeight,
        gapSize = gapSize
    })
    if not container then
        print("container is nil")
        return nil
    end
    for i = 1, size do
        local x = math.floor((i-1)/numCols)+1
        local y = i-(x-1)*numCols
        container:insertAt(tiles[i], x, y)
    end

    container.x = maxW/2
    container.y = container.realH/2
    scrollView:insert(container)

    scrollView.tiles = tiles
    scrollView.size = size
    scrollView.selectedTile = selectedTile

    return scrollView
end

return TileBox