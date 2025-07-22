E_MODEL_SAUL_MOBILE = smlua_model_util_get_id("saul_mobile_geo")

function carhoko(m)
if (m.controller.buttonPressed & X_BUTTON) ~= 0 then
if 1 == 0 then
    m.pos.y = m.pos.y + 20
spawn_sync_object(id_bhvKoopaShell, E_MODEL_SAUL_MOBILE, m.pos.x, m.pos.y - 20, m.pos.z,
--- @param o Object
function(o)
end)
end
end
end

hook_event(HOOK_MARIO_UPDATE, carhoko)