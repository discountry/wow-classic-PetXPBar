-- Frame
local b = CreateFrame("Frame", nil, UIParent)
b:SetSize(80, 10)
b:ClearAllPoints()
b:SetPoint("LEFT", PetFrameHappiness, "RIGHT", 32, 0)

-- Status Bar
b.bar = CreateFrame("StatusBar", nil, b);
b.bar:SetWidth(76); b.bar:SetHeight(8);
b.bar:SetPoint("LEFT", b, "LEFT", 2, 0);
b.bar:SetMinMaxValues(0, 100)
b.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
b.bar:SetStatusBarColor(50/255, 100/255, 200/255)

-- Border Texture
b.bar.border = b.bar:CreateTexture("PetXPBarBorder", "OVERLAY");
b.bar.border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
b.bar.border:SetAllPoints(b);

-- Level Text
b.bar.tex = b.bar:CreateFontString("PetXPBarText", "OVERLAY", "GameFontHighlight");
b.bar.tex:SetPoint("CENTER", b, "CENTER", 0 , 1);
b.bar.tex:SetJustifyH("CENTER");
b.bar.tex:SetJustifyV("CENTER");

function updateBar()
	currXP, nextXP = GetPetExperience()
	print("Pet Xp: " .. string.format("%2.2f", (currXP / nextXP) * 100) .. "%")
	b.bar:SetValue((currXP / nextXP) * 100)
end

function updateText()
	local level = UnitLevel("pet")
	print("Pet Level: " .. level)
	b.bar.tex:SetText(level)
end

-- Update Progress
local initer = CreateFrame("Frame")
initer:RegisterEvent("UNIT_PET_EXPERIENCE")
initer:SetScript("OnEvent", function(self, event)
	updateBar()
	updateText()
end)

local reloader = CreateFrame("Frame")
reloader:RegisterEvent("UNIT_PET")
reloader:SetScript("OnEvent", function(self, event)
	hunterPetActive()
end)

function hunterPetActive ()
	local hasUI, isHunterPet = HasPetUI();
	b:Hide()
	if hasUI then
		if isHunterPet then
			updateBar()
			updateText()
			b:Show()
		end
	end
end

hunterPetActive()
