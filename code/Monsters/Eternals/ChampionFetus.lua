local EternalFetus = {};

--Add to Eternal List
Agony:AddEternal(EntityType.ENTITY_BABY,0,"Champion Fetus")


function EternalFetus:ai_main(entity)
	local sprite = entity:GetSprite();

	if (entity.SubType == 15  and entity.Variant == 3) then
		entity.ProjectileDelay = -1 --prevent original shot
		if (sprite:IsEventTriggered("Convert")) then
			--entity:PlaySound(SoundEffect.SOUND_BLOODSHOOT, 1.0, 0, false, 1.0)
			local nearestEnt = Agony:getNearestEnemy(entity)
			if Agony:HasEternalSubtype(nearestEnt.Type,nearestEnt.Variant) and nearestEnt.SubType ~= 15 then
				local col = Color(255,255,255,255,0,0,0) -- Used to set the poof color
				col:Reset()
				nearestEnt:ToNPC():Morph(nearestEnt.Type, nearestEnt.Variant, 15, -1)
				Game():SpawnParticles(nearestEnt.Position, EffectVariant.POOF01, 1, 1, col, 0)
			end
		end
	end
end

--Callbacks
Agony:AddCallback(ModCallbacks.MC_NPC_UPDATE, EternalFetus.ai_main, EntityType.ENTITY_BABY);