local user_helper = require('app.utils.user_helper')
local log = require('log')

local function init(opts) -- luacheck: no unused args
    if opts.is_master then
        -- FIXME move to migrations
        user_helper.create_users()
    end
    return true
end

local function stop()
    return true
end

local function validate_config(conf_new, conf_old) -- luacheck: no unused args
    return true
end

local function apply_config(conf, opts) -- luacheck: no unused args
    if opts.is_master then
        -- todo
    end
    return true
end

return {
    role_name = 'app.roles.storage',
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
    dependencies = { 'cartridge.roles.crud-storage' },
}