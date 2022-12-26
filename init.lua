function change_immortal_group(player, value) 
        local armor = player:get_armor_groups()
        armor.immortal = value
        player:set_armor_groups(armor)
end

function set_immortality(name, value)
    local player = minetest.get_player_by_name(name)
    if player then
        change_immortal_group(player,value)
    end
end

minetest.register_on_priv_grant(function (name, granter, priv)
    if priv == "creative" then
        set_immortality(name, 1)
    end
end)
    
minetest.register_on_priv_revoke(function (name, granter, priv) 
    if priv == "creative" then
        set_immortality(name, 0)
    end
end)


minetest.register_on_joinplayer(function (player,last_login)
    if minetest.check_player_privs(player, {creative=true}) then
        change_immortal_group(player, 1)
    end
end)
