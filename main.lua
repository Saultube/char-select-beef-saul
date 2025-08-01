-- name: [CS] \\#882A40\\Beef \\#88D549\\Saul
-- description: Have you Ever Became Beefified

local gStateExtras = {}
for i = 0, MAX_PLAYERS - 1 do
    gStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gStateExtras[i]
    e.rotAngle = 0
end

velroy = 0
SAUL_TWIRL = audio_sample_load("saulsfucklintworl.mp3") -- saul twirl sfx
E_MODEL_BEEF_SAUL = smlua_model_util_get_id("beef_saul_geo") -- main saul model
E_MODEL_MIK_SAUL = smlua_model_util_get_id("mik_saul_geo") -- saul alt 1 (miku)
E_MODEL_DOC_SAUL = smlua_model_util_get_id("doc_saul_geo") -- saul alt 1 (doctor)
E_MODEL_OLD_SAUL = smlua_model_util_get_id("old_saul_geo") -- saul alt 1 (old)
E_MODEL_CLASSIC_SAUL = smlua_model_util_get_id("classic_saul_geo") -- saul alt 1 (classic)
E_MODEL_EVIL_FUCKED_UP = smlua_model_util_get_id("evilfuckedup_geo") -- evil fucked up (evil fucked up)
E_MODEL_SAUL_STAR = smlua_model_util_get_id("saulstar_geo") -- saul's star thingy majig
TEX_BEEF_SAUL_PIC = get_texture_info("beefsaulicon") -- main saul icon
TEX_MIK_SAUL_PIC = get_texture_info("saulkuicon") -- miku saul icon
TEX_CAC_SAUL_PIC = get_texture_info("cactaulicon") -- outdated icon
TEX_OLD_SAUL_PIC = get_texture_info("saulpfpimg") -- old saul icon
TEX_CLASSIC_SAUL_PIC = get_texture_info("clasicon") -- classic saul icon
TEX_EVIL_FUCKED_UP_ICO = get_texture_info("evilfuckedupicon") -- evil fucked up icon
TEX_EVIL_FUCKED_UP_AR = get_texture_info("evilfuckedupar") -- evil fucked up reaction him
TEX_BEEF_SAUL_METER = get_texture_info("saulmeter") -- saul meter shape
TEX_BEEF_SAUL_METER_BACK = get_texture_info("saulmeterback") -- saul meter gradient
TEX_BEEF_SAUL_METER_BACK2 = get_texture_info("saulmeterbg2") -- saul meter "red"
TEX_CACTUS_METER = get_texture_info("cactussaulmeter") -- outdated health meter for Doc saul
TEX_MIKAUL_METER = get_texture_info("mikaulmeter") -- unfinished meter for miku
TEX_OLD_METER = get_texture_info("oldmeter") -- archival meter from old saul and used on classic saul
TEX_OLD_METER_BACK = get_texture_info("oldmeterbg") -- same thing as above but for the death sprites
TEX_ALT_METER = get_texture_info("nonmovesetmeter") -- moveset for when movesets are disabled
TEX_ALT_METER_BACK = get_texture_info("nonmovesetmeterback") -- same thing as above but for the death sprites
TEX_SAULTV = get_texture_info("saultv") -- saul tv haha funny pizza tower no it isn't shut the fuck up
TEX_HOLYSHIT = get_texture_info("healthred") -- saul low health meter probably will remove later
TEX_SAUL_MENU_BG = get_texture_info("thebg") -- saul menu background thingys
TEX_REACTION = get_texture_info("evilfuckedupreatcion") -- "Evil Fucked Up Live Reaction"
TEX_REACTIONBG = get_texture_info("evilfuckedupreatcionbg") -- bob render for the BG of 'evil fucked up live reaction'
TEX_THESHIT = get_texture_info("saulpicon") -- saul power up icon thingys thank you kaktus
TEX_SAUL_GRAFFITI = get_texture_info("graffitisaul") -- saul graffiti for CS 1.16
SAUL_EYES_SMILE = 9 -- saul custom smile eye state thank you chrrli
twirltimer = 12 -- saul twirl move timer setting up
crouchj = 0 -- saul crouch jump timer setting up

-- Saul Clone Behaviour

local function scloninit(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    cur_obj_update_floor_and_walls();
    o.oFaceAngleYaw = m.faceAngle.y
    o.oFaceAngleRoll = 0
    o.oVelY = 0
    o.oGraphYOffset = 32
end

local function sclonloop(o)
m = gMarioStates[0]
o.header.gfx.animInfo.curAnim = get_mario_vanilla_animation(m.marioObj.header.gfx.animInfo.animID)
if o.oVelY > -24 then
o.oVelY = o.oVelY - 1.5
else
o.oVelY = -24
end
o.oPosY = o.oPosY + o.oVelY
o.oTimer = o.oTimer + 1
if o.oTimer > 12 then
spawn_triangle_break_particles(1, E_MODEL_BUBBA, 0.5, 1)
obj_mark_for_deletion(o)
end
if o.oPosY < o.oFloorHeight then
o.oPosY = o.oFloorHeight
end
end

id_bhvSclon = hook_behavior(id_bhvSclon, OBJ_LIST_GENACTOR, true, scloninit, sclonloop)

-- CUSTOM ACTIONS!!!! HOORAY!!!

ACT_SAUL_QUADRUPLE_JUMP = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR)
--ACT_SAUL_WALL_GRAB = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_AIR)

function act_saul_quadruple_jump(m)
    local e = gStateExtras[m.playerIndex]
    local stepResult = common_air_action_step(m, ACT_TRIPLE_JUMP_LAND, CHAR_ANIM_FLY_FROM_CANNON, AIR_STEP_CHECK_LEDGE_GRAB)
    if m.input & INPUT_Z_PRESSED ~= 0 then
        set_mario_action(m, ACT_GROUND_POUND, 0)
    end
    if m.input & INPUT_B_PRESSED ~= 0 then
        set_mario_action(m, ACT_DIVE, 0)
    end
    e.rotAngle = e.rotAngle + 7500 -- remove this and the line below this unless you want your custom anim to be spinning (assuming you're doing one)
    m.marioObj.header.gfx.angle.x = e.rotAngle
    m.actionTimer = m.actionTimer + 1
end
hook_mario_action(ACT_SAUL_QUADRUPLE_JUMP, act_saul_quadruple_jump)

ACT_SAUL_TWIRL = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR)

function act_saul_twirl(m)
    local e = gStateExtras[m.playerIndex]
    common_air_action_step(m, ACT_JUMP_LAND, CHAR_ANIM_TWIRL, AIR_STEP_CHECK_LEDGE_GRAB)
    set_character_animation(m, CHAR_ANIM_TWIRL)
    e.rotAngle = e.rotAngle + 6500
    m.marioObj.header.gfx.angle.y = e.rotAngle
    m.actionTimer = m.actionTimer + 1
    m.vel.y = m.vel.y / 1.8
    if m.actionTimer > 5 then
    twirltimer = 0
    m.action = ACT_FREEFALL
    end
end
hook_mario_action(ACT_SAUL_TWIRL, act_saul_twirl)

ACT_SAUL_DASH = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR)

function act_saul_dash(m)
    common_air_action_step(m, ACT_TRIPLE_JUMP_LAND, CHAR_ANIM_TWIRL, AIR_STEP_CHECK_LEDGE_GRAB)
    set_character_animation(m, CHAR_ANIM_TWIRL)
    if m.actionTimer == 0 then
    play_character_sound(m, CHAR_SOUND_YAHOO_WAHA_YIPPEE)
    end
    m.faceAngle.y = m.intendedYaw
    m.actionTimer = m.actionTimer + 1
    m.forwardVel = 46 / ((m.actionTimer + 1) / 8)
    m.vel.y = m.vel.y * 0.84
    if m.actionTimer > 10 then
    m.action = ACT_FREEFALL
    end
    spawn_sync_object(id_bhvSclon, E_MODEL_BLUE_COIN_NO_SHADOW, m.pos.x, m.pos.y, m.pos.z,
	--- @param o Object
	function(o)
    obj_scale(o, 0.5)
	end)
end
hook_mario_action(ACT_SAUL_DASH, act_saul_dash)

-- I actually tried my hardest to get this to work. it just would not
-- function act_saul_wall_grab(m)
--     local stepResult = common_air_action_step(m, ACT_FREEFALL_LAND, CHAR_ANIM_START_WALLKICK, AIR_STEP_HIT_WALL)
--     if m.input & INPUT_A_PRESSED ~= 0 then
--         set_mario_action(m, ACT_WALL_KICK_AIR, 0)
--     end
--     --if m.wall ~= nil then m.forwardVel = 0 end
--     if m.wall == nil then
--         set_mario_action(m, ACT_FREEFALL, 0)
--     end
--     if m.actionTimer > 70 then
--         set_mario_action(m, ACT_FREEFALL, 0)
--     end
--     m.forwardVel = -1
--     m.vel.y = 0
--     m.actionTimer = m.actionTimer + 1
-- end
-- hook_mario_action(ACT_SAUL_WALL_GRAB, act_saul_wall_grab)

TEXT_MOD_NAME = ("[CS] Beef Saul")

if _G.charSelectExists then
    ANIMTABLE_BEEF_SAUL = {
        [CHAR_ANIM_SINGLE_JUMP] = "saul_jump",
        [CHAR_ANIM_WALKING] = "saul_anim_waklslowowo",
        [CHAR_ANIM_START_CRAWLING] = "saul_crawl_start",
        [CHAR_ANIM_STOP_CRAWLING] = "saul_crawl_stop",
        [CHAR_ANIM_START_CROUCHING] = "saul_crouch_start",
        [CHAR_ANIM_CROUCHING] = "saul_crouch",
        [CHAR_ANIM_STOP_CROUCHING] = "saul_crouch_stop",
        [CHAR_ANIM_BACKWARD_AIR_KB] = "saul_flung",
        [CHAR_ANIM_RUNNING] = "saulrun",
        [CHAR_ANIM_HANG_ON_OWL] = "saul_hang",
        [CHAR_ANIM_RIDING_SHELL] = "car_driving",
        [CHAR_ANIM_JUMP_RIDING_SHELL] = "car_driving",
        [CHAR_ANIM_START_RIDING_SHELL] = "car_driving",
        [CHAR_ANIM_BEND_KNESS_RIDING_SHELL] = "car_driving",
        [_G.charSelect.CS_ANIM_MENU] = "saul_menu",
    }
end

ANIMTABLE_CLASSIC_SAUL = {
    [CHAR_ANIM_STAR_DANCE] = "MARIO_ANIM_CLUB_DANCE",
    [CHAR_ANIM_DOUBLE_JUMP_FALL] = "SAUL_ANIM_4C",
    [CHAR_ANIM_TIPTOE] = "saul_anim_waklslowowo",
    [CHAR_ANIM_WALKING] = "saul_anim_waklslowowo",
    [CHAR_ANIM_RUNNING] = "saul_anim_waklslowowo",
    [CHAR_ANIM_SINGLE_JUMP] = "saul_jump",
    [CHAR_ANIM_LAND_FROM_SINGLE_JUMP] = "saul_jump_land",
    [CHAR_ANIM_IDLE_HEAD_LEFT] = "classic_idle",
    [CHAR_ANIM_IDLE_HEAD_RIGHT] = "classic_idle",
    [CHAR_ANIM_IDLE_HEAD_CENTER] = "classic_idle",
    [CHAR_ANIM_FIRST_PERSON] = "classic_idle",
    [_G.charSelect.CS_ANIM_MENU] = "classic_idle",
}

theopav = 0

saultwirltable = { -- saul twirl table
    [ACT_JUMP] = true,
    [ACT_DOUBLE_JUMP] = true,
    [ACT_TRIPLE_JUMP] = true,
    [ACT_SAUL_QUADRUPLE_JUMP] = true,
    [ACT_FREEFALL] = true,
    [ACT_SIDE_FLIP] = true,
    [ACT_BACKFLIP] = true,
    [ACT_WALL_KICK_AIR] = true,
    [ACT_LONG_JUMP] = true,
}

sauldashtable = { -- saul dash table
    [ACT_JUMP] = true,
    [ACT_DOUBLE_JUMP] = true,
    [ACT_SIDE_FLIP] = true,
    [ACT_BACKFLIP] = true,
}

local jumpanim = 1
local sctimer = 0.5
function saulthings(m)
    if _G.charSelectExists then
        if m.action == ACT_JUMP then
            if jumpanim == 1 then
                smlua_anim_util_set_animation(m.marioObj, "saul_jump")
            else
                smlua_anim_util_set_animation(m.marioObj, "saul_jump_2")
            end
        else
        if m.playerIndex == 0 then
            jumpanim = jumpanim + 1
        if jumpanim > 2 then
            jumpanim = 0
        end
        end
    end
        if m.playerIndex == 0 then
            twirltimer = twirltimer + 1
            if m.action == ACT_CROUCHING then
            crouchj = crouchj + 1
               if crouchj > 30 then
               m.marioObj.header.gfx.scale.y = 0.5 + sctimer
               sctimer = sctimer * 0.9
               end
            else
        crouchj = 0
        sctimer = 0.5
        end
        end
        if m.action == ACT_TWIRLING then
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
            m.vel.y = m.vel.y - 20
            end
        end
        if m.action == ACT_SLEEPING then
            velroy = velroy + 1/30
            m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y + (velroy * 5) + (5 * (math.sin(velroy * 180)))
            m.marioObj.header.gfx.angle.z = m.marioObj.header.gfx.angle.z + (0x0 + (velroy * (300000 * (velroy / 800))))
            m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.z + (0x0 + (velroy * (150000 * (velroy / 800))))
        elseif m.action == ACT_WAKING_UP then
            velroy = velroy * 0.8
            m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y + (velroy * 5) + (5 * (math.sin(velroy * 180)))
            m.marioObj.header.gfx.angle.z = m.marioObj.header.gfx.angle.z + (0x0 + (velroy * (300000 * (velroy / 800))))
            m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.z + (0x0 + (velroy * (150000 * (velroy / 800))))
        else
        velroy = 0
        end
        if saultwirltable[m.action] ~= nil then -- checking a table to see if mario's action can twirl
            if m.vel.y < 5 then -- checking if mario's Y Vel is under 20
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then -- A Button check
                if twirltimer > 12 then
                    twirltimer = 0
                    m.vel.y = m.vel.y / 4
                    audio_sample_play(SAUL_TWIRL, m.pos, get_volume_sfx() / 76)
        set_mario_action(m, ACT_SAUL_TWIRL, 0) -- setting twirl act
                end
            end
            end
        end
        if sauldashtable[m.action] ~= nil then
            if (m.controller.buttonPressed & X_BUTTON) ~= 0 then
            m.vel.y = 50
            set_mario_action(m, ACT_SAUL_DASH, 0)
            end
        end
        if m.action == ACT_GROUND_POUND then
            if m.pos.y > m.floorHeight then
            m.pos.y = m.pos.y - (m.actionTimer * 3)
            m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y - (m.actionTimer * 3)
            end
        end
        if m.pos.y ~= m.floorHeight then
        m.marioObj.header.gfx.scale.y = m.marioObj.header.gfx.scale.y + (math.abs(m.vel.y) / 100)
        else
            if m.action ~= ACT_DEATH_EXIT and m.action ~= ACT_UNUSED_DEATH_EXIT and m.action ~= ACT_SPECIAL_DEATH_EXIT and m.action ~= ACT_FALLING_DEATH_EXIT and m.action ~= ACT_SPECIAL_EXIT_AIRBORNE and m.action ~= ACT_FALLING_EXIT_AIRBORNE and m.action ~= ACT_EMERGE_FROM_PIPE then
            m.vel.y = m.vel.y * 0.92
            end
        end
        if m.action == ACT_RIDING_HOOT then
        smlua_anim_util_set_animation(m.marioObj, "saul_hang")
        m.marioObj.header.gfx.pos.y = m.pos.y + 85
        end
        m.marioObj.header.gfx.scale.x = m.marioObj.header.gfx.scale.x - (math.abs(m.vel.y) / 150)
        m.marioObj.header.gfx.scale.z = m.marioObj.header.gfx.scale.z - ((math.abs(m.vel.y) / 150) - math.abs(m.forwardVel) / 325)
        if (m.health >> 8) < 1 then
            if theopav < 25 then
                theopav = theopav + 1
            end
        else
            theopav = 0
        end
        if m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT or m.action == ACT_STAR_DANCE_WATER or m.action == ACT_FLYING then
            if _G.charSelect.character_get_current_costume() == 1 then
            m.marioBodyState.eyeState = SAUL_EYES_SMILE
            end
        end
        if _G.charSelect.is_menu_open() then
        m.marioBodyState.eyeState = MARIO_EYES_LOOK_RIGHT
        end
        if _G.charSelect.character_get_current_costume() ~= ALT_CLASSIC_SAUL then
        if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_IDLE_HEAD_LEFT then
            m.marioBodyState.eyeState = MARIO_EYES_LOOK_RIGHT
        end
        if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_GENERAL_FALL then
            if m.vel.y < -10 then
                m.marioBodyState.eyeState = MARIO_EYES_LOOK_DOWN
            end
        end
        if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_IDLE_HEAD_RIGHT then
            m.marioBodyState.eyeState = MARIO_EYES_LOOK_LEFT
        end
        if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_FIRE_LAVA_BURN then
            m.marioBodyState.eyeState = MARIO_EYES_DEAD
        end
        end
        if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_RUNNING then
            m.marioBodyState.torsoAngle.x = 0
            m.marioBodyState.torsoAngle.z = 0
            m.marioBodyState.torsoAngle.y = 0
            if (m.controller.buttonDown & Y_BUTTON) ~= 0 then
                if m.forwardVel >= 0 then
                    m.forwardVel = m.forwardVel + (m.forwardVel * 0.255)
                    smlua_anim_util_set_animation(m.marioObj, "saul_cust_sprint")
                end
            else
            if _G.charSelect.character_get_current_costume() ~= ALT_CLASSIC_SAUL then
                smlua_anim_util_set_animation(m.marioObj, "saulrun")
            else
                smlua_anim_util_set_animation(m.marioObj, "saul_anim_waklslowowo")
            end
            end
        end
    end
end

-- Saul Cursor
local TEX_SAUL_HAND_OPEN = get_texture_info("saulhandopen")
local TEX_SAUL_HAND_CLOSED = get_texture_info("saulhandclosed")
local pastchar = _G.charSelect.character_get_current_number()
function sauldialog(m)
if m.playerIndex == 0 then
    if _G.charSelectExists then
        if CT_BEEF_SAUL == _G.charSelect.character_get_current_number() then
            set_dialog_override_color(178, 204, 102, 175, 255, 255, 255, 255)
            texture_override_set("gd_texture_hand_open", TEX_SAUL_HAND_OPEN)
            texture_override_set("gd_texture_hand_closed", TEX_SAUL_HAND_CLOSED)
            hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAGS_POWER)
        end
    if _G.charSelect.character_get_current_number() ~= CT_BEEF_SAUL then
        if _G.charSelect.character_get_current_number() ~= pastchar then
            reset_dialog_override_color()
            texture_override_reset("gd_texture_hand_open")
            texture_override_reset("gd_texture_hand_closed")
            hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) |HUD_DISPLAY_FLAGS_POWER)
        end
    end
pastchar = _G.charSelect.character_get_current_number()
end
end
end

hook_event(HOOK_MARIO_UPDATE, sauldialog)

PALETTE_OLD_SAUL =  {
    [PANTS]  = { r = 0x47, g = 0x27, b = 0x69 }, -- 472769
    [SHIRT]  = { r = 0xb2, g = 0xcc, b = 0x66 }, -- B2CC66
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x90, g = 0x77, b = 0x5a }, -- 90775A
    [SKIN]   = { r = 0xff, g = 0xde, b = 0xa4 }, -- FEC28d
    [CAP]    = { r = 0xb2, g = 0xcc, b = 0x66 }, -- B2CC66
    [EMBLEM] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
}

PALETTE_BEEF_SAUL =  {
    [PANTS]  = { r = 0x88, g = 0x2A, b = 0x40 }, -- 882A40
    [SHIRT]  = { r = 0x88, g = 0xd5, b = 0x49 }, -- 88D549
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x61, g = 0x53, b = 0x48 }, -- 615348
    [SKIN]   = { r = 0xff, g = 0xd2, b = 0x94 }, -- FFD294
    [CAP]    = { r = 0x88, g = 0xd5, b = 0x49 }, -- 88D549
    [EMBLEM] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
}

PALETTE_MIK_SAUL =  {
    [PANTS]  = { r = 0x88, g = 0x2A, b = 0x40 }, -- 882A40
    [SHIRT]  = { r = 0xC3, g = 0xCD, b = 0xD6 }, -- C3CDD6
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x6D, g = 0xD4, b = 0xA3 }, -- 6DD4A3
    [SKIN]   = { r = 0xff, g = 0xd2, b = 0x94 }, -- FFD294
    [CAP]    = { r = 0x6D, g = 0xD4, b = 0xA3 }, -- 6DD4A3
    [EMBLEM] = { r = 0xE8, g = 0x22, b = 0x84 }, -- E82284
}

PALETTE_CLASSIC_SAUL =  {
    [PANTS]  = { r = 0x2e, g = 0x14, b = 0x57 }, -- 2E1457
    [SHIRT]  = { r = 0xb2, g = 0xcc, b = 0x66 }, -- b2cc66
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0x64, g = 0x1c, b = 0x0e }, -- 641c0e
    [HAIR]   = { r = 0x37, g = 0x1A, b = 0x01 }, -- 371A01
    [SKIN]   = { r = 0xfe, g = 0xc1, b = 0x79 }, -- fec179
    [CAP]    = { r = 0xb2, g = 0xcc, b = 0x66 }, -- b2cc66
    [EMBLEM] = { r = 0xb2, g = 0xcc, b = 0x66 }, -- b2cc66
}

local COURSE_BEEF_SAUL = {
    top = get_texture_info("thetopcourse"),
    bottom = get_texture_info("thebottomcourse"),
}

VOICETABLE_BEEF_SAUL = { -- Voices from the Islander from Lego Racers (1999)
    [CHAR_SOUND_ATTACKED] = {'bsouch.aiff', 'bshurt2.aiff'},
    [CHAR_SOUND_COUGHING1] = nil,
    [CHAR_SOUND_COUGHING2] = nil,
    [CHAR_SOUND_COUGHING3] = nil,
    [CHAR_SOUND_DOH] = 'bsouch.aiff', -- long jump bump
    [CHAR_SOUND_DROWNING] = 'bsfall.aiff',
    [CHAR_SOUND_DYING] = 'bsouch.aiff',
    [CHAR_SOUND_EEUH] = nil, -- climbing ledge
    [CHAR_SOUND_GROUND_POUND_WAH] = 'bswoh.aiff',
    [CHAR_SOUND_HAHA] = 'bshey.aiff',
    [CHAR_SOUND_HAHA_2] = 'bshey.aiff',
    [CHAR_SOUND_HERE_WE_GO] = 'bswoohoo.aiff', -- getting star/power up
    [CHAR_SOUND_HOOHOO] = 'bswoohoo.aiff',
    [CHAR_SOUND_HRMM] = 'bswoh.aiff', -- lifting
    [CHAR_SOUND_IMA_TIRED] = nil,
    [CHAR_SOUND_MAMA_MIA] = 'bshurt2.aiff',
    [CHAR_SOUND_LETS_A_GO] = 'bswoohoo.aiff', -- starting level
    [CHAR_SOUND_ON_FIRE] = 'bsfall.aiff',
    [CHAR_SOUND_OOOF] = 'bswoohoo.aiff',
    [CHAR_SOUND_OOOF2] = 'bshurt2.aiff', -- thrown out of painting
    [CHAR_SOUND_PANTING] = nil,
    [CHAR_SOUND_PANTING_COLD] = nil,
    [CHAR_SOUND_PUNCH_HOO] = 'bswoh.aiff', -- kick
    [CHAR_SOUND_PUNCH_WAH] = 'bswoh.aiff', -- punch 2
    [CHAR_SOUND_PUNCH_YAH] = 'bswoh.aiff', -- punch 1
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'bsfall.aiff',
    [CHAR_SOUND_SNORING1] = nil,
    [CHAR_SOUND_SNORING2] = nil,
    [CHAR_SOUND_SNORING3] = nil,
    [CHAR_SOUND_TWIRL_BOUNCE] = 'bslj.aiff',
    [CHAR_SOUND_UH] = 'bshurt2.aiff', -- wall bonk
    [CHAR_SOUND_UH2] = nil, -- landing long jump
    [CHAR_SOUND_UH2_2] = nil, -- same as uh2 maybe??
    [CHAR_SOUND_WAAAOOOW] = 'bsfall.aiff',
    [CHAR_SOUND_WAH2] = 'bswoh.aiff', -- throw
    [CHAR_SOUND_WHOA] = 'bsfall.aiff',
    [CHAR_SOUND_YAHOO] = {'bswoohoo.aiff', 'bslj.aiff'},
    [CHAR_SOUND_YAWNING] = nil,
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'bslj.aiff',
    [CHAR_SOUND_YAH_WAH_HOO] = {'bswoh.aiff', 'bshey.aiff'},
    [CHAR_SOUND_HELLO] = nil,
    [CHAR_SOUND_PRESS_START_TO_PLAY] = nil,
    [CHAR_SOUND_OKEY_DOKEY] = 'bswoohoo.aiff'
}

function on_set_bsaul_action(m)
    if m.action == ACT_SAUL_QUADRUPLE_JUMP then -- im using HOOK_ON_SET_MARIO_ACTION to define m.vel.y, but you can also just use the custom action's m.actionTimer for this! -kak
        m.vel.y = 90
        play_character_sound(m, CHAR_SOUND_WHOA)
    end
end

function before_set_bsaul_action(m, inc)
    if inc == ACT_TRIPLE_JUMP_LAND and m.action ~= ACT_SAUL_QUADRUPLE_JUMP then -- i had to do some shenagigans with ACT_TRIPLE_JUMP_LAND to change that to ACT_DOUBLE_JUMP_LAND since triple jump land restricts a presses.
        return ACT_DOUBLE_JUMP_LAND
    end
    if inc == ACT_BACKFLIP then
        if crouchj > 30 then
    return ACT_SAUL_QUADRUPLE_JUMP
        end
    end
    if inc == ACT_TRIPLE_JUMP and m.prevAction == ACT_TRIPLE_JUMP and m.action == ACT_DOUBLE_JUMP_LAND then
        return ACT_SAUL_QUADRUPLE_JUMP
    end
end

TEX_VANILLA_STAR = get_texture_info("texture_hud_char_star")
if _G.charSelectExists then
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) |HUD_DISPLAY_FLAGS_POWER)
    CT_BEEF_SAUL = _G.charSelect.character_add("Beef Saul", {"Saul has Finally been Beefified"}, "Saul", {r = 136, g = 213, b = 73}, E_MODEL_BEEF_SAUL, CT_TOAD, TEX_BEEF_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_graffiti(CT_BEEF_SAUL, TEX_SAUL_GRAFFITI)
    _G.charSelect.character_add_animations(E_MODEL_BEEF_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_DOC_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_OLD_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_MIK_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_CLASSIC_SAUL, ANIMTABLE_CLASSIC_SAUL)
    _G.charSelect.credit_add("Beef Saul", "Chrrli", "Main Saul Icon")
    _G.charSelect.credit_add("Beef Saul", "Kaktus", "Old Saul Icon, Quadruple Jump Code")
    _G.charSelect.credit_add("Beef Saul", "Squishy", "Redoing a TON of Code")
    _G.charSelect.credit_add("Beef Saul", "Jer", "Voicetable Stuff")
    CT_FUCKED_UP = _G.charSelect.character_add("Evil Fucked Up", {"Evil Fucked Up"}, "Evil Fucked Up", {r = 43, g = 76, b = 1}, E_MODEL_EVIL_FUCKED_UP, CT_LUIGI, TEX_EVIL_FUCKED_UP_ICO, 3, 0)
    _G.charSelect.character_add_course_texture(CT_BEEF_SAUL, COURSE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_BEEF_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_DOC_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_OLD_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_MIK_SAUL, VOICETABLE_BEEF_SAUL)
    theoptionvar = _G.charSelect.add_option("Hide Menu Art", 0, 1, {"Off", "On"}, {"This toggle hides Saul's Menu Art."}, true)
    _G.charSelect.config_character_sounds()
    _G.charSelect.character_hook_moveset(CT_BEEF_SAUL, HOOK_MARIO_UPDATE, saulthings)
    _G.charSelect.character_hook_moveset(CT_BEEF_SAUL, HOOK_ON_SET_MARIO_ACTION, on_set_bsaul_action)
    _G.charSelect.character_hook_moveset(CT_BEEF_SAUL, HOOK_BEFORE_SET_MARIO_ACTION, before_set_bsaul_action)
    _G.charSelect.character_add_palette_preset(E_MODEL_BEEF_SAUL, PALETTE_BEEF_SAUL)
    _G.charSelect.character_set_category(CT_BEEF_SAUL, "DXA")
    _G.charSelect.character_set_category(CT_BEEF_SAUL, "Squishy Workshop")
    _G.charSelect.character_add_celebration_star(E_MODEL_BEEF_SAUL, E_MODEL_SAUL_STAR, TEX_VANILLA_STAR)
    ALT_CACTUS_SAUL = _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Doctor Saul", {"ouch"}, "Saul", {r = 0, g = 178, b = 0}, E_MODEL_DOC_SAUL, CT_TOAD, TEX_CAC_SAUL_PIC, 1, 0)
    ALT_OLD_SAUL = _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Old Saul", {"hey uh the thigny"}, "Saul", {r = 178, g = 204, b = 102}, E_MODEL_OLD_SAUL, CT_TOAD, TEX_OLD_SAUL_PIC, 1, 0)
    ALT_MIKU_SAUL = _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Hatsaulne Miku", {"これはすごい"}, "Saul", {r = 155, g = 213, b = 225}, E_MODEL_MIK_SAUL, CT_TOAD, TEX_MIK_SAUL_PIC, 1, 0)
    ALT_CLASSIC_SAUL = _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Classic Saul", {"Everybody's favorite private sm64 modder - Saul 2024"}, "Saul", {r = 71, g = 39, b = 105}, E_MODEL_CLASSIC_SAUL, CT_MARIO, TEX_CLASSIC_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_palette_preset(E_MODEL_DOC_SAUL, PALETTE_BEEF_SAUL)
    _G.charSelect.character_add_palette_preset(E_MODEL_OLD_SAUL, PALETTE_OLD_SAUL)
    _G.charSelect.character_add_palette_preset(E_MODEL_MIK_SAUL, PALETTE_MIK_SAUL)
    _G.charSelect.character_add_palette_preset(E_MODEL_CLASSIC_SAUL, PALETTE_CLASSIC_SAUL)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end