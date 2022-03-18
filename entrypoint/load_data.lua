local function connect()
    local result, err

    local timeout = 10
    local admin_login = 'admin'
    local admin_password = 'secret-cluster-cookie'
    local host = "localhost"
    local port = 3301
    local srv = admin_login .. ':' .. admin_password .. '@' .. host .. ':' .. port

    local conn = require('net.box').connect(srv)
    return conn
end

local function disconnect(conn)
    conn:close()
end

local function dofile(conn, file)
    local _, err = conn:call('dofile', {file} )
    if err then
        print(tostring(err))
    else
        print("Executed dofile for " .. file)
    end
end

local function main()
    local conn = connect()
    dofile(conn, '/entrypoint/test_data.lua')
    disconnect(conn)
end

main()
