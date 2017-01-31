--Supreme King Violent Spirit
function c511009518.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511009518.filter)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511009518)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511009518.eqlimit)
	c:RegisterEffect(e3)
end
c511009518.collection={
-- Odd-Eyes Raging Dragon 
-- Odd-Eyes Rebellion Dragon
-- Supreme King Dragon Zarc
-- Number C80: Requiem in Berserk
-- Number 80: Rhapsody in Berserk
-- D/D/D Supreme King Kaiser
-- King of Yamimakai
[86238081]=true;[45627618]=true;[13331639]=true;
[69455834]=true;[20563387]=true;[93568288]=true;
[44186624]=true;
}
function c511009518.eqlimit(e,c)
	return (c:IsSetCard(0x1fb) or c511009518.collection[c:GetCode()]) 
end
function c511009518.filter(c)
	return (c:IsSetCard(0x1fb) or c511009518.collection[c:GetCode()]) 
		and c:IsFaceup() 
end