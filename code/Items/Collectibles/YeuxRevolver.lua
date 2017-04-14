--local item_YeuxRev = Isaac.GetItemIdByName("Yeux Revolver");
local yeuxRev =  {
	TearBool = false
}

function yeuxRev:cacheUpdate (player,cacheFlag)
	if (player:HasCollectible(CollectibleType.AGONY_C_YEUX_REVOLVER)) then
		if (cacheFlag == CacheFlag.CACHE_DAMAGE) then
			player.Damage = (player.Damage + 3.42069*player:GetCollectibleNum(CollectibleType.AGONY_C_YEUX_REVOLVER))
		end
		if (cacheFlag == CacheFlag.CACHE_SHOTSPEED) then
			player.ShotSpeed = (player.ShotSpeed + 1.69420*player:GetCollectibleNum(CollectibleType.AGONY_C_YEUX_REVOLVER))
		end
		if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then
			yeuxRev.TearBool = true
		end
	end
end

function yeuxRev:onUpdate()
	local ents = Isaac.GetRoomEntities()
	local player = Game():GetPlayer(0)
  if player:HasCollectible(CollectibleType.AGONY_C_YEUX_REVOLVER) then
    for _,entity in pairs(ents) do
    	if entity.Type == EntityType.ENTITY_TEAR then
    		if entity.FrameCount == 0 then
    			entity:GetSprite():Load("gfx/effect/tear_yeuxrevolver.anm2", true)
    			local anim = ""
    			if player.Damage < 3.5 then
    				anim = "RegularTear7"
    			elseif player.Damage < 10 then
					anim = "RegularTear7"
    			else
    				anim = "RegularTear7"
    			end
          		entity:GetSprite():LoadGraphics()
          		entity:GetSprite():Play(anim, true)
          		local v1 = Vector(0, 1)
          		local v2 = entity.Velocity:Normalized()
          		local angle = math.acos(v1:Dot(v2))
          		entity:GetSprite().Rotation = entity.Velocity:GetAngleDegrees()
    		end
    	end
    end
  end
end

--FireDelay workaround
function yeuxRev:updateFireDelay()
	local player = Isaac.GetPlayer(0)
	if (yeuxRev.TearBool == true) then
		player.MaxFireDelay = player.MaxFireDelay + 4*player:GetCollectibleNum(CollectibleType.AGONY_C_YEUX_REVOLVER);
		yeuxRev.TearBool = false;
	end
end

function yeuxRev:onTakeDmg(hurtEntity, dmgAmount, dmgFlags, source, countdown)
	local player = Game():GetPlayer(0)
	if player:HasCollectible(CollectibleType.AGONY_C_YEUX_REVOLVER) and hurtEntity:IsVulnerableEnemy() then
		local time = Isaac.GetTime()
		while time + 45 >Isaac.GetTime() do
		end
		Game():ShakeScreen(math.floor(player.Damage/3))
	end
end

Agony:AddCallback(ModCallbacks.MC_POST_UPDATE, yeuxRev.onUpdate)
Agony:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, yeuxRev.onTakeDmg)
Agony:AddCallback(ModCallbacks.MC_POST_UPDATE, yeuxRev.updateFireDelay)
Agony:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, yeuxRev.cacheUpdate)