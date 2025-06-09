E_MODEL_SAUL_MOBILE = smlua_model_util_get_id("saul_mobile_geo")

local function scarinit(o)
    o.collisionData = smlua_collision_util_get("saul_mobile_collision")
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE|OBJ_FLAG_MOVE_XZ_USING_FVEL|OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    cur_obj_update_floor_and_walls();
    obj_scale(o, 1/2.21776)
    o.oGravity = 0
end

local function scarloop(o)
m = gMarioStates[0]
smlua_anim_util_set_animation(o, "car_drive")
o.oPosX = m.pos.x
o.oPosY = m.floorHeight + 80
o.oPosZ = m.pos.z
end

id_bhvSaulCar = hook_behavior(id_bhvSaulCar, OBJ_LIST_GENACTOR, true, scarinit, scarloop)

function carhoko(m)
if (m.controller.buttonPressed & X_BUTTON) ~= 0 then
end
end

hook_event(HOOK_MARIO_UPDATE, carhoko)