local errors = require('errors')
local log = require('log')

local function handle_error(err, req)
    local json_resp = {}
    log.error("Error processing request " ..
            req.path .. ": " .. tostring(err))
    json_resp = { msg = tostring(err) }
    return json_resp
end

local function truncate_space(req)
    local space_id = req:stash('space')
    local result, err = crud.truncate(space_id)
    local json_resp, status
    if err then
        json_resp = handle_error(err, req)
        status = 500
    else
        json_resp = {}
        status = 200
    end
    local resp = req:render({ json = json_resp })
    resp.status = status
    return resp
end

local function get_tuple_by_pk(req)
    local space_id = req:stash('space')
    local pk = req:param('pk')
    local result, err = crud.get(space_id, pk)
    local json_resp, status
    if err then
        json_resp = handle_error(err, req)
        status = 500
    else
        local obj = crud.unflatten_rows(result.rows, result.metadata)[1]
        json_resp = { object = obj }
        status = 200
    end
    local resp = req:render({ json = json_resp })
    resp.status = status
    return resp
end

local function delete_tuple_by_pk(req)
    local space_id = req:stash('space')
    local pk = req:param('pk')
    local result, err = crud.delete(space_id, pk)
    local json_resp, status
    if err then
        json_resp = handle_error(err, req)
        status = 500
    else
        local obj = crud.unflatten_rows(result.rows, result.metadata)[1]
        json_resp = { object = obj }
        status = 200
    end
    local resp = req:render({ json = json_resp })
    resp.status = status
    return resp
end

return {
    truncate_space = truncate_space,
    get_tuple_by_pk = get_tuple_by_pk,
    delete_tuple_by_pk = delete_tuple_by_pk
}