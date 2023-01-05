function set_immortality(player, value)
    -- Attempt to turn a string player name into a userdata object
    if type(player) == "string" then
        player = minetest.get_player_by_name(player)
    end

    -- If we were given a userdata object, or were able to retrieve one
    if type(player) == "userdata" then
        local armor = player:get_armor_groups()
        armor.immortal = value
        player:set_armor_groups(armor)
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

minetest.register_on_joinplayer(function (player, last_login)
    if minetest.check_player_privs(player, {creative=true}) then
        set_immortality(player, 1)
    end
end)
