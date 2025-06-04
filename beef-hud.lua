saultvtimer = 0

xletter = ">"

movingvar = 0

theopacityvar = 0

function hud()
if _G.charSelectExists then
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
    djui_hud_render_texture_tile(TEX_CACTUS_METER, 10, 176, 1, 1, thecactustimer, (4 - (m.health >> 9)) * 64, 64, 64)
    djui_hud_print_text(tostring(xletter), 69, 212, 1)
    djui_hud_print_text(tostring(m.health >> 8), 84, 212, 1)
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
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud)