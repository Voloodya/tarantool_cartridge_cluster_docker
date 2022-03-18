return {
    up = function()

        local user_helper = require('app.utils.user_helper')

        local grant_crud = function(user)
            user_helper.grant_space_access("_ddl_sharding_key", user, true)
            user_helper.grant_space_access("_index", user, true)
            user_helper.grant_space_access("_space", user, true)
            user_helper.grant_all_execute(user)
        end

        grant_crud(user_helper.router_user)
        return true
    end
}