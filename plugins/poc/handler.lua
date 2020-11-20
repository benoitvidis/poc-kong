local kong = kong

local BasePlugin = require "kong.plugins.base_plugin"

local PocHandler = BasePlugin:extend()

PocHandler.VERSION = "1.0.0"
PocHandler.PRIORITY = 10

function PocHandler:new()
  PocHandler.super.new(self, "poc-plugin")
end

function PocHandler:rewrite(config)
  -- redirect /now to /yyyy/mm/dd/hh/ii
  if kong.request.get_path() == "/now" then
    kong.response.set_header("Location", os.date("/%Y/%m/%d/%H/%M"))
    kong.response.exit(302, "Redirecting to now")
    return
  end

  -- redirect /today to /yyyy/mm/dd
  if kong.request.get_path() == "/today" then
    kong.response.set_header("Location", os.date("/%Y/%m/%d"))
    kong.response.exit(302, "Redirecting to today")
    return
  end

  PocHandler.super.rewrite(self)
end

return PocHandler