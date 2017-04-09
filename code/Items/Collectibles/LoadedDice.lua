--local item_LoadedDice = Isaac.GetItemIdByName("Loaded Dice")
local loadedDice =  {}

function loadedDice:onUse()
	local ent = Isaac.GetRoomEntities()
	for i = 1, #ent, 1 do
		if ent[i].Type == 5 and ent[i].Variant == 100 then
			ent[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BUTTER_BEAN,true)
			--POOF!
			local col = Color(255,255,255,255,0,0,0) -- Used to set the poof color
			col:Reset()
			Game():SpawnParticles(ent[i].Position, EffectVariant.POOF01, 1, 1, col, 0)
		end
	end
	return true
end

Agony:AddCallback(ModCallbacks.MC_USE_ITEM, loadedDice.onUse, CollectibleType.AGONY_C_LOADED_DICE)