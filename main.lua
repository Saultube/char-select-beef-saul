-- name: [CS] \\#88D549\\Beef Saul
-- description: Have you Ever Became Beefified

velroy = 0
E_MODEL_BEEF_SAUL = smlua_model_util_get_id("beef_saul_geo")
E_MODEL_MIK_SAUL = smlua_model_util_get_id("mik_saul_geo")
E_MODEL_CAC_SAUL = smlua_model_util_get_id("cactus_saul_geo")
E_MODEL_OLD_SAUL = smlua_model_util_get_id("old_saul_geo")
TEX_BEEF_SAUL_PIC = get_texture_info("beefsaulicon")
TEX_MIK_SAUL_PIC = get_texture_info("saulkuicon")
TEX_CAC_SAUL_PIC = get_texture_info("cactaulicon")
TEX_OLD_SAUL_PIC = get_texture_info("saulpfpimg")
TEX_BEEF_SAUL_METER = get_texture_info("saulmeter")
TEX_BEEF_SAUL_METER_BACK = get_texture_info("saulmeterback")
TEX_BEEF_SAUL_METER_BACK2 = get_texture_info("saulmeterbg2")
TEX_CACTUS_METER = get_texture_info("cactussaulmeter")
TEX_MIKAUL_METER = get_texture_info("mikaulmeter")
TEX_OLD_METER = get_texture_info("oldmeter")
TEX_OLD_METER_BACK = get_texture_info("oldmeterbg")
TEX_SAULTV = get_texture_info("saultv")
TEX_HOLYSHIT = get_texture_info("healthred")
TEX_SAUL_MENU_PIC = get_texture_info("saulchar")
TEX_CAC_MENU_PIC = get_texture_info("cacchar")
TEX_MIK_MENU_PIC = get_texture_info("mikchar")
TEX_SAUL_MENU_BG = get_texture_info("thebg")
TEX_THESHIT = get_texture_info("saulpicon")
SAUL_EYES_SMILE = 9

TEXT_MOD_NAME = ("[CS] Beef Saul")

if _G.charSelectExists then
ANIMTABLE_BEEF_SAUL = {
[CHAR_ANIM_SINGLE_JUMP] = "saul_jum",
[CHAR_ANIM_WALKING] = "saul_anim_waklslowowo",
[CHAR_ANIM_START_CRAWLING] = "saul_crawl_start",
[CHAR_ANIM_STOP_CRAWLING] = "saul_crawl_stop",
[CHAR_ANIM_START_CROUCHING] = "saul_crouch_start",
[CHAR_ANIM_CROUCHING] = "saul_crouch",
[CHAR_ANIM_STOP_CROUCHING] = "saul_crouch_stop",
[CHAR_ANIM_BACKWARD_AIR_KB] = "saul_flung",
[CHAR_ANIM_RUNNING] = "saulrun",
[CHAR_ANIM_HANG_ON_OWL] = "saul_hang",
[_G.charSelect.CS_ANIM_MENU] = "sauls_completely_new_menu_pose",
}
end

HM_BSAL= {
    label = {
        left = get_texture_info("transparentfulll"),
        right = get_texture_info("transparentfulll"),
    },
    pie = {
        [1] = get_texture_info("transparentfulll"),
        [2] = get_texture_info("transparentfulll"),
        [3] = get_texture_info("transparentfulll"),
        [4] = get_texture_info("transparentfulll"),
        [5] = get_texture_info("transparentfulll"),
        [6] = get_texture_info("transparentfulll"),
        [7] = get_texture_info("transparentfulll"),
        [8] = get_texture_info("transparentfulll"),
    }
}

theopav = 0

function saulthings(m)
    if _G.charSelectExists then
        set_dialog_override_color(178, 204, 102, 175, 255, 255, 255, 255)
        if m.action == ACT_FLYING then
        m.marioBodyState.eyeState = SAUL_EYES_SMILE
        m.marioObj.header.gfx.angle.x = math.floor(m.marioObj.header.gfx.angle.x / 1024) * 1024
        m.marioObj.header.gfx.angle.z = math.floor(m.marioObj.header.gfx.angle.z / 1024) * 1024
        else
        if m.pos.y ~= m.floorHeight then
        m.marioObj.header.gfx.scale.y = 1 + (math.abs(m.vel.y) / 100)
        else
        m.vel.y = m.vel.y * 0.92
        end
        if m.action == ACT_RIDING_HOOT then
        smlua_anim_util_set_animation(m.marioObj, "saul_hang")
        m.marioObj.header.gfx.pos.y = m.pos.y + 85
        end
    end
        m.marioObj.header.gfx.scale.x = 1 - (math.abs(m.vel.y) / 150)
        m.marioObj.header.gfx.scale.z = 1 - ((math.abs(m.vel.y) / 150) - math.abs(m.forwardVel) / 325)
        if (m.health >> 8) < 1 then
            if theopav < 25 then
            theopav = theopav + 1
            end
        else
        theopav = 0
        end
        if m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT or m.action == ACT_STAR_DANCE_WATER then
        if _G.charSelect.character_get_current_costume() == 1 then
        m.marioBodyState.eyeState = SAUL_EYES_SMILE
        end
        end
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
        smlua_anim_util_set_animation(m.marioObj, "saulrun")
    end
end
if _G.charSelect.character_get_current_costume() == 2 then
    if m.pos.y < m.waterLevel then
        m.vel.y = 100
        m.forwardVel = -85
        m.action = ACT_THROWN_BACKWARD
    end
end
end
end

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

COURSE_BEEF_SAUL = {
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

if _G.charSelectExists then
    CT_BEEF_SAUL = _G.charSelect.character_add("Beef Saul", {"Saul has Finally been Beefified"}, "Saul (Player Icon By Chrrli On The Discord)", {r = 136, g = 213, b = 73}, E_MODEL_BEEF_SAUL, CT_TOAD, TEX_BEEF_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_animations(E_MODEL_BEEF_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_CAC_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_OLD_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_MIK_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_BEEF_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_CAC_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_OLD_SAUL, VOICETABLE_BEEF_SAUL)
    _G.charSelect.character_add_voice(E_MODEL_MIK_SAUL, VOICETABLE_BEEF_SAUL)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BEEF_SAUL then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BEEF_SAUL then return _G.charSelect.voice.snore(m) end
    end)
    _G.charSelect.character_hook_moveset(CT_BEEF_SAUL, HOOK_MARIO_UPDATE, saulthings)
    _G.charSelect.character_add_health_meter(CT_BEEF_SAUL, HM_BSAL)
    _G.charSelect.character_add_palette_preset(E_MODEL_BEEF_SAUL, PALETTE_BEEF_SAUL)
    _G.charSelect.character_set_category(CT_BEEF_SAUL, "DXA")
    _G.charSelect.character_set_category(CT_BEEF_SAUL, "Squishy Workshop")
    _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Cactus Saul", {"ouch"}, "Saul", {r = 0, g = 178, b = 0}, E_MODEL_CAC_SAUL, CT_BEEF_SAUL, TEX_CAC_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Old Saul", {"hey uh the thigny"}, "Saul, icon by kaktus", {r = 178, g = 204, b = 102}, E_MODEL_OLD_SAUL, CT_BEEF_SAUL, TEX_OLD_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_costume(CT_BEEF_SAUL, "Hatsaulne Miku", {"これはすごい"}, "Saul, Miku?!?", {r = 155, g = 213, b = 225}, E_MODEL_MIK_SAUL, CT_BEEF_SAUL, TEX_MIK_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_palette_preset(E_MODEL_CAC_SAUL, PALETTE_BEEF_SAUL)
    _G.charSelect.character_add_palette_preset(E_MODEL_OLD_SAUL, PALETTE_OLD_SAUL)
    _G.charSelect.character_add_palette_preset(E_MODEL_MIK_SAUL, PALETTE_MIK_SAUL)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end