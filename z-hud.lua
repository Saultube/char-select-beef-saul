saultvtimer = 0
xletter = ">"
movingvar = 0
theopacityvar = 0

local saulMenuTextures = {
    [1] = get_texture_info("saulchar"),
    [ALT_CACTUS_SAUL] = get_texture_info("cacchar"),
    [ALT_OLD_SAUL] = get_texture_info("saulchar"),
    [ALT_MIKU_SAUL] = get_texture_info("mikchar"),
    [ALT_CLASSIC_SAUL] = get_texture_info("classicmenu"),
}

local function hud_render()
    local currNum = _G.charSelect.character_get_current_number()
    local currCostume = _G.charSelect.character_get_current_costume()
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
        if CT_BEEF_SAUL == currNum then
            saultvtimer = saultvtimer + 1
            if saultvtimer == 15 then
                saultvtimer = 1
            end
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_set_font(FONT_HUD)
            if currCostume == 1 then
                if _G.charSelect.is_menu_open() == false then
                    djui_hud_render_texture(TEX_BEEF_SAUL_METER_BACK, 29, 202, 3.5, 0.5)
                    djui_hud_render_texture(TEX_BEEF_SAUL_METER_BACK2, 146 - ((2326 - (m.health)) / 17.45), 202, ((2176 - m.health)) / 535, 0.5)
                    djui_hud_render_texture(TEX_BEEF_SAUL_METER, 19, 192, 1, 1)
                end
            end
            thecactustimer = (math.floor(saultvtimer / 8)) * 64
            if _G.charSelect.is_menu_open() == false then
                if currCostume == 2 then
                    if (math.ceil((m.health >> 8) / 2)) >= 1 then
                        djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, (4 - math.ceil((m.health >> 8) / 2)) * 64, 64, 64)
                    else
                        djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, 192, 64, 64)
                    end
                    djui_hud_print_text(tostring(xletter), 69, 208, 1)
                    djui_hud_print_text(tostring(m.health >> 8), 83, 208, 1)
                end
            end
            if _G.charSelect.is_menu_open() == false then
                if _G.charSelect.character_get_current_costume() == 3 or _G.charSelect.character_get_current_costume() == 5 then
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
                    local playerColorCap = network_player_get_override_palette_color(gNetworkPlayers[m.playerIndex], CAP)
                    local playerColorGloves = network_player_get_override_palette_color(gNetworkPlayers[m.playerIndex], GLOVES)
                    djui_hud_set_color(255, 255, 255, 255)
                    djui_hud_render_texture_tile(TEX_THESHIT, 8, 32, 1, 1, 0, 0, 64, 64)
                    djui_hud_set_color(playerColorCap.r, playerColorCap.g, playerColorCap.b, 255)
                    djui_hud_render_texture_tile(TEX_THESHIT, 8, 32, 1, 1, 64, 0, 64, 64)
                    djui_hud_set_color(playerColorGloves.r, playerColorGloves.g, playerColorGloves.b, 255)
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

local function menu_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    local currNum = _G.charSelect.character_get_current_number()
    local currCostume = _G.charSelect.character_get_current_costume()
    if CT_BEEF_SAUL == currNum then
        if _G.charSelect.is_menu_open() == true then
            theopacityvar = theopacityvar * 1.4
            if theopacityvar > 1 then
                theopacityvar = 1
            end
        else
            theopacityvar = theopacityvar * 0.6
        end
        if _G.charSelect.get_options_status(theoptionvar) == 1 then
        theopacityvar = theopacityvar * 0.6
        end
        djui_hud_set_color(255, 255, 255, 180 * theopacityvar)
        djui_hud_render_texture(TEX_SAUL_MENU_BG, -5 + movingvar, -5 + movingvar, (djui_hud_get_screen_width() + 8) / 64, (djui_hud_get_screen_width() + 8) / 64)
        djui_hud_set_color(255, 255, 255, 245 * ((math.floor(theopacityvar * 20)) / 20))
        if saulMenuTextures[currCostume] then
            djui_hud_render_texture(saulMenuTextures[currCostume], (djui_hud_get_screen_width() / 2) - 64, (djui_hud_get_screen_height() / 2) - 32, 0.5, 0.5)
        end
    else
        theopacityvar = theopacityvar * 0.6
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, menu_render)

local function alt_meter_render()
    m = gMarioStates[0]
    djui_hud_set_resolution(RESOLUTION_N64)
    if _G.charSelect.get_options_status(6) == 0 then
      if CT_BEEF_SAUL == _G.charSelect.character_get_current_number() then
                if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_RUNNING then
                 m.marioBodyState.torsoAngle.x = 0
                 m.marioBodyState.torsoAngle.z = 0
                 m.marioBodyState.torsoAngle.y = 0
                end
         if _G.charSelect.is_menu_open() == false then
         djui_hud_render_texture(TEX_ALT_METER_BACK, 2, 176, 1, 1)
          if m.health >> 8 > 0 then
          djui_hud_render_texture_tile(TEX_ALT_METER, 2, 176, 1, 1, (8 - (m.health >> 8)) * 64, 0, 64, 64)
          end
        end
    end
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, alt_meter_render)

local function fucked_up_evil()
    m = gMarioStates[0]
    djui_hud_set_resolution(RESOLUTION_N64)
    if CT_FUCKED_UP == _G.charSelect.character_get_current_number() then
    djui_hud_render_texture(TEX_REACTIONBG, 0, 176, 0.25, 0.25)
    djui_hud_render_texture(TEX_EVIL_FUCKED_UP_AR, 0 + (m.health / 100), 192 - (m.health / 450), 0.75, 0.75)
    djui_hud_render_texture(TEX_REACTION, 0, 176, 0.125, 0.125)
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, fucked_up_evil)

_G.charSelect.character_hook_moveset(CT_BEEF_SAUL, HOOK_ON_HUD_RENDER_BEHIND, hud_render)