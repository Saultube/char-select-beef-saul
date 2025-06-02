-- name: [CS] \\#88D549\\Beef Saul
-- description: Have you Ever Became Beefified

local velroy = 0
local E_MODEL_BEEF_SAUL = smlua_model_util_get_id("beef_saul_geo")
local E_MODEL_MIK_SAUL = smlua_model_util_get_id("mik_saul_geo")
local E_MODEL_CAC_SAUL = smlua_model_util_get_id("cactus_saul_geo")
local E_MODEL_OLD_SAUL = smlua_model_util_get_id("old_saul_geo")
local TEX_BEEF_SAUL_PIC = get_texture_info("beefsaulicon")
local TEX_MIK_SAUL_PIC = get_texture_info("saulkuicon")
local TEX_CAC_SAUL_PIC = get_texture_info("cactaulicon")
local TEX_OLD_SAUL_PIC = get_texture_info("saulpfpimg")
local TEX_BEEF_SAUL_METER = get_texture_info("saulmeter")
local TEX_BEEF_SAUL_METER_BACK = get_texture_info("saulmeterback")
local TEX_BEEF_SAUL_METER_BACK2 = get_texture_info("saulmeterbg2")
local TEX_CACTUS_METER = get_texture_info("cactussaulmeter")
local TEX_MIKAUL_METER = get_texture_info("mikaulmeter")
local TEX_OLD_METER = get_texture_info("oldmeter")
local TEX_OLD_METER_BACK = get_texture_info("oldmeterbg")
local TEX_SAULTV = get_texture_info("saultv")
local TEX_HOLYSHIT = get_texture_info("healthred")
local TEX_SAUL_MENU_PIC = get_texture_info("saulchar")
local TEX_CAC_MENU_PIC = get_texture_info("cacchar")
local TEX_MIK_MENU_PIC = get_texture_info("mikchar")
local TEX_SAUL_MENU_BG = get_texture_info("thebg")
local TEX_THESHIT = get_texture_info("saulpicon")
local SAUL_EYES_SMILE = 9
local TEXT_MOD_NAME = ("[CS] Beef Saul")
local ANIMTABLE_BEEF_SAUL = {
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
local HM_BSAL= {
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
local function saulthings(m)
        set_dialog_override_color(178, 204, 102, 175, 255, 255, 255, 255)
        if m.action == ACT_FLYING then
        m.marioBodyState.eyeState = SAUL_EYES_SMILE
        m.marioObj.header.gfx.angle.x = math.floor(m.marioObj.header.gfx.angle.x / 1024) * 1024
        m.marioObj.header.gfx.angle.z = math.floor(m.marioObj.header.gfx.angle.z / 1024) * 1024
        end
        if m.action ~= ACT_FLYING then
        if m.pos.y ~= m.floorHeight then
        m.marioObj.header.gfx.scale.y = 1 + (math.abs(m.vel.y) / 100)
        end
        if m.action == ACT_RIDING_HOOT then
        smlua_anim_util_set_animation(m.marioObj, "saul_hang")
        m.marioObj.header.gfx.pos.y = m.pos.y + 90
        end
        if m.pos.y == m.floorHeight then
        m.vel.y = m.vel.y * 0.92
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
local PALETTE_OLD_SAUL =  {
    [PANTS]  = { r = 0x47, g = 0x27, b = 0x69 }, -- 472769
    [SHIRT]  = { r = 0xb2, g = 0xcc, b = 0x66 }, -- B2CC66
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x90, g = 0x77, b = 0x5a }, -- 90775A
    [SKIN]   = { r = 0xff, g = 0xde, b = 0xa4 }, -- FEC28d
    [CAP]    = { r = 0xb2, g = 0xcc, b = 0x66 }, -- B2CC66
    [EMBLEM] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
}
local PALETTE_BEEF_SAUL =  {
    [PANTS]  = { r = 0x88, g = 0x2A, b = 0x40 }, -- 882A40
    [SHIRT]  = { r = 0x88, g = 0xd5, b = 0x49 }, -- 88D549
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x61, g = 0x53, b = 0x48 }, -- 615348
    [SKIN]   = { r = 0xff, g = 0xd2, b = 0x94 }, -- FFD294
    [CAP]    = { r = 0x88, g = 0xd5, b = 0x49 }, -- 88D549
    [EMBLEM] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
}
local PALETTE_MIK_SAUL =  {
    [PANTS]  = { r = 0x88, g = 0x2A, b = 0x40 }, -- 882A40
    [SHIRT]  = { r = 0xC3, g = 0xCD, b = 0xD6 }, -- C3CDD6
    [GLOVES] = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [SHOES]  = { r = 0xff, g = 0xff, b = 0xff }, -- FFFFFF
    [HAIR]   = { r = 0x6D, g = 0xD4, b = 0xA3 }, -- 6DD4A3
    [SKIN]   = { r = 0xff, g = 0xd2, b = 0x94 }, -- FFD294
    [CAP]    = { r = 0x6D, g = 0xD4, b = 0xA3 }, -- 6DD4A3
    [EMBLEM] = { r = 0xE8, g = 0x22, b = 0x84 }, -- E82284
}
local COURSE_BEEF_SAUL = {
    top = get_texture_info("thetopcourse"),
    bottom = get_texture_info("thebottomcourse"),
}
if _G.charSelectExists then
    CT_BEEF_SAUL = _G.charSelect.character_add("Beef Saul", {"Saul has Finally been Beefified"}, "Saul (Player Icon By Chrrli On The Discord)", {r = 136, g = 213, b = 73}, E_MODEL_BEEF_SAUL, CT_TOAD, TEX_BEEF_SAUL_PIC, 1, 0)
    _G.charSelect.character_add_animations(E_MODEL_BEEF_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_CAC_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_OLD_SAUL, ANIMTABLE_BEEF_SAUL)
    _G.charSelect.character_add_animations(E_MODEL_MIK_SAUL, ANIMTABLE_BEEF_SAUL)
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

saultvtimer = 0

xletter = ">"

movingvar = 0

theopacityvar = 0

function hud()
djui_hud_set_resolution(RESOLUTION_N64)
uses = djui_hud_get_screen_width() / 64
    m = gMarioStates[0]
    movingvar = movingvar + 0.1
    if theopacityvar < 0.01 then
    theopacityvar = 0.01
    end
    if m.playerIndex == 0 then
            if movingvar >= djui_hud_get_screen_width() / 64 then
    movingvar = 0
    end
                        djui_hud_set_color(255, 255, 255, 180 * theopacityvar)
        djui_hud_render_texture(TEX_SAUL_MENU_BG, -5 + movingvar, -5 + movingvar, (djui_hud_get_screen_width() + 8) / 64, (djui_hud_get_screen_width() + 8) / 64)
    if CT_BEEF_SAUL == _G.charSelect.character_get_current_number() then
    if (m.health >> 8) < 1 then
    djui_hud_set_color(255, 255, 255, theopav * 10.2)
    djui_hud_set_font(FONT_CUSTOM_HUD)
    if _G.charSelect.is_menu_open() == false then
    djui_hud_print_text("aw man, you died", djui_hud_get_screen_width()/2 - (djui_hud_measure_text("aw man, you died") * 1)/2, djui_hud_get_screen_height() / 2, 1)
    end
    end
    if _G.charSelect.is_menu_open() == true then
            theopacityvar = theopacityvar * 1.4
                if theopacityvar > 1 then
    theopacityvar = 1
    end
        else
            theopacityvar = theopacityvar * 0.6
        end
        djui_hud_set_color(255, 255, 255, 225 * theopacityvar)
        if _G.charSelect.character_get_current_costume() == 1 then
        djui_hud_render_texture(TEX_SAUL_MENU_PIC, (djui_hud_get_screen_width() / 2) - 64, (djui_hud_get_screen_height() / 2) - 32, 0.5, 0.5)
        elseif _G.charSelect.character_get_current_costume() == 4 then
        djui_hud_render_texture(TEX_MIK_MENU_PIC, (djui_hud_get_screen_width() / 2) - 64, (djui_hud_get_screen_height() / 2) - 32, 0.5, 0.5)
        elseif _G.charSelect.character_get_current_costume() == 2 then
        djui_hud_render_texture(TEX_CAC_MENU_PIC, (djui_hud_get_screen_width() / 2) - 64, (djui_hud_get_screen_height() / 2) - 32, 0.5, 0.5)
        end
    else
    theopacityvar = theopacityvar * 0.6
    end
    if CT_BEEF_SAUL == _G.charSelect.character_get_current_number() then
    saultvtimer = saultvtimer + 1
    if saultvtimer == 15 then
    saultvtimer = 1
    end
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_set_font(FONT_HUD)
    if _G.charSelect.character_get_current_costume() == 1 then
        if _G.charSelect.is_menu_open() == false then
    djui_hud_render_texture(TEX_BEEF_SAUL_METER_BACK, 29, 202, 3.5, 0.5)
    djui_hud_render_texture(TEX_BEEF_SAUL_METER_BACK2, 146 - ((2326 - (m.health)) / 17.45), 202, ((2176 - m.health)) / 535, 0.5)
    djui_hud_render_texture(TEX_BEEF_SAUL_METER, 19, 192, 1, 1)
        end
    end
    thecactustimer = (math.floor(saultvtimer / 8)) * 64
    if _G.charSelect.is_menu_open() == false then
    if _G.charSelect.character_get_current_costume() == 2 then
    if (m.health >> 8) == 8 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 0, 64, 64)
    elseif (m.health >> 8) == 7 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 0, 64, 64)
    elseif (m.health >> 8) == 6 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 64, 64, 64)
    elseif (m.health >> 8) == 5 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 64, 64, 64)
    elseif (m.health >> 8) == 4 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 128, 64, 64)
    elseif (m.health >> 8) == 3 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 128, 64, 64)
    elseif (m.health >> 8) == 2 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 192, 64, 64)
    elseif (m.health >> 8) == 1 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 192, 64, 64)
    elseif (m.health >> 8) < 1 then
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 192, 64, 64)
    end
    djui_hud_print_text(tostring(xletter), 69, 192, 2)
    djui_hud_print_text(tostring(m.health >> 8), 99, 192, 2)
end
end
if _G.charSelect.is_menu_open() == false then
if _G.charSelect.character_get_current_costume() == 3 then
djui_hud_render_texture(TEX_OLD_METER_BACK, 5, 176, 1, 1)
    if m.health >> 8 > 0 then
djui_hud_render_texture_tile(TEX_OLD_METER, 22, 192, 1, 1, ((m.health >> 8) - 1) * 32, 0, 32, 32)
    end
end
end
if _G.charSelect.character_get_current_costume() == 4 then
    if _G.charSelect.is_menu_open() == false then
djui_hud_render_texture_tile(TEX_MIKAUL_METER, 5, 176, 1, 1, 0, 0, math.floor(((m.health - 255) / 1921) * 64), 64)
    end
end
    if _G.charSelect.character_get_current_costume() == 1 then
        if _G.charSelect.is_menu_open() == false then
    djui_hud_set_color(255, 255, 255, 255 - (theopav * 10.2))
    if saultvtimer <= 7 then
    djui_hud_render_texture_tile(TEX_SAULTV, 25, 128, 1, 1, 0, 0, 64, 64)
    end
    if saultvtimer > 7 then
    djui_hud_render_texture_tile(TEX_SAULTV, 25, 128, 1, 1, 64, 0, 64, 64)
    end
    djui_hud_set_color(255, 255, 255, 255)
end
    if (m.flags & (MARIO_WING_CAP | MARIO_METAL_CAP | MARIO_VANISH_CAP)) ~= 0 then
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_render_texture_tile(TEX_THESHIT, 8, 32, 1, 1, 0, 0, 64, 64)
    djui_hud_set_color(network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], CAP, 0), network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], CAP, 1), network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], CAP, 2), 255)
    djui_hud_render_texture_tile(TEX_THESHIT, 8, 32, 1, 1, 64, 0, 64, 64)
    djui_hud_set_color(network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], GLOVES, 0), network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], GLOVES, 1), network_player_get_override_palette_color_channel(gNetworkPlayers[m.playerIndex], GLOVES, 2), 255)
    djui_hud_render_texture_tile(TEX_THESHIT, 8, 32, 1, 1, 0, 64, 64, 64)
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_print_text(tostring(math.ceil(m.capTimer/30)), 29, 67, 1)
    end
end
    if (255 - ((m.health - 255) / 1)) >= 0 then
    djui_hud_set_color(255, 255, 255, (255 - ((m.health - 255) / 1)))
    else
    djui_hud_set_color(255, 255, 255, 0)
    end
    djui_hud_render_texture(TEX_HOLYSHIT, 0, 0, djui_hud_get_screen_width() / 32, djui_hud_get_screen_height() / 32)
    return
end
else
theopacityvar = theopacityvar * 0.6
end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud)