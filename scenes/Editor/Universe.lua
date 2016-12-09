local GameConfig = require("GameConfig")

local World = require("scenes.Editor.World")

local Universe = {}

Universe.new = function()
	local universe = display.newGroup()
	universe.worlds = {}
	universe.size = 0

	function universe:addWorld(world)
		self.size = self.size + 1
		universe.worlds[self.size] = world
		-- set world's position
		world.x = (self.size-1) * world.width
		world.y = 0
		self:insert(world)
	end

	function universe:getWorld(idx)
		return self.worlds[idx]
	end

	function universe:toggleBoardVisible()
		for i = 1, self.size do
			self.worlds[i]:toggleBoardVisible()
		end
	end

	return universe
end


return Universe