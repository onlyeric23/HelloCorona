local config = {}

config.contentWidth = display.contentWidth
config.contentHeight = display.contentHeight

config.basicHeight = 720

config.imageSuffix = {
    ["@2x"] = 1.5,
    ["@3x"] = 2.5,
    ["@4x"] = 3
}

config.scaleFactor =  config.contentHeight / config.basicHeight

config.fontSize = 14

-- Editor layout size
config.attrTableWidth = config.contentWidth*4/16
config.attrTableHeight = config.contentHeight

config.controlBarWidth = config.contentWidth*8/16
config.controlBarHeight = 30
config.controlBtnHeight = 24

config.previewWidth = config.contentWidth*8/16
config.previewHeight = config.contentHeight-config.controlBarHeight

config.tileBoxWidth = config.contentWidth*4/16
config.tileBoxHeight = config.contentHeight/2

-- Preview
config.previewScale = 0.3
config.previewScaleStep = 0.05
config.previewOffsetX = 0
config.previewOffsetY = 0

-- Layer
config.layerSize = 8
config.layerScale = 0.3
config.layOffset = 50
config.layerDistance = 600

-- Tile box
config.gridWidth = 20
config.gridHeight = 20

return config
