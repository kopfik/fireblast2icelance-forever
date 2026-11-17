-- FireBlast2IceLance - written entirely by AI (Claude), designed and tested in the game by the maintainer.
-- Blizzard's Cooldown Manager lists some cooldowns under a spell you rarely press
-- (Fire Blast shares its cooldown with Ice Lance, but only Fire Blast can be picked).
-- This shows another spell's icon for it - ONLY on the Cooldown Manager's bars.
-- The spell itself, action bars, spellbook and tooltips stay as they are.

-- spell shown by the Cooldown Manager  ->  spell whose icon to show instead (English names)
local ICONS = {
	["Fire Blast"] = "Ice Lance",
}

local VIEWERS = { "EssentialCooldownViewer", "UtilityCooldownViewer", "BuffIconCooldownViewer", "BuffBarCooldownViewer" }

local function IsSecret(v)
	return issecretvalue and issecretvalue(v)
end

-- after the Cooldown Manager has drawn an icon: put the other spell's picture on it
local function Swap(item)
	local spellID = item.GetBaseSpellID and item:GetBaseSpellID()
	if not spellID or IsSecret(spellID) then return end
	local name = C_Spell.GetSpellName(spellID)
	if not name or IsSecret(name) then return end
	local other = ICONS[name]
	if not other then return end
	local icon = C_Spell.GetSpellTexture(other)
	if icon and not IsSecret(icon) and item.GetIconTexture then
		item:GetIconTexture():SetTexture(icon)
	end
end

local function Watch(item)
	if item.claudeIconHooked or not item.RefreshSpellTexture then return end
	item.claudeIconHooked = true
	hooksecurefunc(item, "RefreshSpellTexture", Swap)
	Swap(item)
end

local function Setup()
	for _, name in ipairs(VIEWERS) do
		local viewer = _G[name]
		if viewer and viewer.OnAcquireItemFrame then
			-- icons made later (the Cooldown Manager makes them when the layout changes)
			hooksecurefunc(viewer, "OnAcquireItemFrame", function(_, item) Watch(item) end)
			-- icons that are already there
			if viewer.itemFramePool then
				for item in viewer.itemFramePool:EnumerateActive() do Watch(item) end
			end
		end
	end
end

if C_AddOns.IsAddOnLoaded("Blizzard_CooldownViewer") then
	Setup()
else
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, _, name)
		if name == "Blizzard_CooldownViewer" then
			self:UnregisterEvent("ADDON_LOADED")
			Setup()
		end
	end)
end
