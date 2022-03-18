local cartridge = require('cartridge')
local membership = require('membership')
local user_helper = require('app.utils.user_helper')

--- Grant permissions to call API methods.
--- This method is idempotent.
local function init_permissions()
    -- Grant user permissions to be able to execute CRUD functions
    local crud_function = {
        "crud.insert",
        "crud.insert_object",
        "crud.get",
        "crud.replace",
        "crud.replace_object",
        "crud.update",
        "crud.upsert",
        "crud.upsert_object",
        "crud.delete",
        "crud.select",
    }
    for _, fn in ipairs(crud_function) do
        user_helper.grant_func_execute(fn, user_helper.router_user)
    end
    return true
end

local function init_routes()
    local httpd = cartridge.service_get('httpd')
    local routes = require('app.crud_rest')
    httpd:route({ method = 'POST', path = '/data/:space/truncate' }, routes.truncate_space)
    httpd:route({ method = 'GET', path = '/data/:space' }, routes.get_tuple_by_pk)
    httpd:route({ method = 'DELETE', path = '/data/:space' }, routes.delete_tuple_by_pk)
end


local function init(opts) -- luacheck: no unused args
    if opts.is_master then
        user_helper.create_users()
        init_permissions()
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
    return true
end


return {
    role_name = 'app.roles.api',
    init = init,
    stop = stop,
    validate_config = validate_config,
    apply_config = apply_config,
    dependencies = { 'cartridge.roles.crud-router'},
}