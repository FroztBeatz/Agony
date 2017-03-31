local misterBean =  {
	hasItem = nil, --used for costume
	costumeID = nil,
	requireditems = Agony.ENUMS["ItemPools"]["Beans"],
	Items = {} --Keeps track of what Items the player has had
}
misterBean.costumeID = Isaac.GetCostumeIdByPath("gfx/characters/trans_misterbean.anm2")

function misterBean:onPlayerUpdate(player)
	if Game():GetFrameCount() == 1 then
		misterBean.hasItem = false
		misterBean.Items = {}
	end
	misterBean.Items = Agony:getCurrentItems(misterBean.requireditems)
	if #misterBean.Items > 2 then
		if misterBean.hasItem == false then
			player:AddNullCostume(misterBean.costumeID)
			misterBean.hasItem = true
			--POOF!
			local col = Color(255,255,255,255,0,0,0) -- Used to set the poof color
			col:Reset()
			Game():SpawnParticles(player.Position, EffectVariant.POOF01, 1, 1, col, 0)
		end
	end
end


function misterBean:onTakeDmg(hurtEntity, dmgAmount, dmgFlags, source, countdown)
    local player = Isaac.GetPlayer(0)
    if source.Type == EntityType.ENTITY_TEAR and misterBean.hasItem then
    	--Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.FIREWORKS , 0, source.Position, Vector(0,0), player)
    	if math.random(5) == 1 then
    		Game():Fart(source.Position, 25, player, 1, 0)
    	elseif math.random(10) == 1 then
    		game():ButterBeanFart(source.Position, 25, player, true)
    	end
    end
end

Agony:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, misterBean.onTakeDmg)
Agony:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, misterBean.onPlayerUpdate)