local item_LoadedDice = Isaac.GetItemIdByName("Loaded Dice")
local loadedDice =  {}

function loadedDice:rerollIntoButterBean()
	local ent = Isaac.GetRoomEntities()
	for i = 1, #ent, 1 do
		if ent[i].Type == 5 and ent[i].Variant == 100 then
			ent[i]:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BUTTER_BEAN,true)
		end
	end
end

Agony:AddCallback(ModCallbacks.MC_USE_ITEM, loadedDice.rerollIntoButterBean, item_LoadedDice)