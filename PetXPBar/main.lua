-- Init
PetXPBar = { }

local currXP, nextXP = GetPetExperience()
local prevXP = nil

-- Frame
local b = CreateFrame("Frame", nil, UIParent)
b:SetSize(80, 10)
b:ClearAllPoints()
b:SetPoint("BOTTOMLEFT", 245, 755)
b:SetFrameLevel(1)

-- Status Bar
b.bar = CreateFrame("StatusBar", nil, b);
b.bar:SetWidth(76); b.bar:SetHeight(5);
b.bar:SetPoint("LEFT", b, "LEFT", 2, 0);
b.bar:SetMinMaxValues(0, 100)
b.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
b.bar:SetStatusBarColor(50/255, 100/255, 200/255)

-- Border Texture
b.bar.border = b:CreateTexture("PetXPBarBorder", "ARTWORK");
b.bar.border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
b.bar.border:SetAllPoints(b);

-- Level Text
b.bar.tex = b.bar:CreateFontString("PetXPBarText", "OVERLAY", "GameFontHighlight");
b.bar.tex:SetPoint("CENTER", b, "CENTER", 0 , 1);
b.bar.tex:SetJustifyH("CENTER");
b.bar.tex:SetJustifyV("CENTER");

-- Update Progress
b.bar:SetValue((currXP / nextXP) * 100)

b.bar:RegisterEvent("UNIT_PET_EXPERIENCE")
b.bar:RegisterEvent("ADDON_LOADED")

b.bar:SetScript("OnEvent", function(self, elapsed)
	PetXPBar:updateBar()
	PetXPBar:updateText()
end)

function PetXPBar:updateText()
	local level = UnitLevel("pet")
	print("Pet Level: " .. level)
	b.bar.tex:SetText(level)
end

function PetXPBar:updateBar()
	currXP, nextXP = GetPetExperience()
	print("Pet Xp: " .. string.format("%2.2f", (currXP / nextXP) * 100) .. "%")
	b.bar:SetValue((currXP / nextXP) * 100)
end