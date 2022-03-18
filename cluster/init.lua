#!/usr/bin/env tarantool

require('strict').on()

-- configure path so that you can run application
-- from outside the root directory

package.setsearchroot()

-- configure cartridge

local cartridge = require('cartridge')

local ok, err = cartridge.cfg({
    roles = {
        'migrator',
        'cartridge.roles.vshard-storage',
        'cartridge.roles.vshard-router',
        'cartridge.roles.crud-storage',
        'cartridge.roles.crud-router',
        'app.roles.api',
        'app.roles.storage',
    },
})

assert(ok, tostring(err))
