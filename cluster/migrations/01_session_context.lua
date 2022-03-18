return {
    up = function()

        local routerSessionContexts = box.schema.space.create('routerSessionContexts', { if_not_exists = true })
        routerSessionContexts:format({
            { name = 'sessionId', type = 'string' },
            { name = 'data', type = 'map', is_nullable = true },
            { name = 'ts', type = 'number' },

            -- vshard bucket id
            { name = 'bucket_id', type = 'unsigned', is_nullable = false },
        })

        routerSessionContexts:create_index('primary', { parts = { { field = 'sessionId' } },
                                                        unique = true,
                                                        if_not_exists = true })

        routerSessionContexts:create_index('bucket_id', {
            parts = { 'bucket_id' },
            unique = false,
            if_not_exists = true
        })

        local utils = require('migrator.utils')
        utils.register_sharding_key('routerSessionContexts', { 'sessionId' })

        local user_helper = require('app.utils.user_helper')
        user_helper.grant_space_access('routerSessionContexts', user_helper.router_user)

        return true
    end
}