--Voltic Spear
function c511002356.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511002356.filter)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511002356.value)
	c:RegisterEffect(e2)
	--equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c511002356.eqlimit)
	c:RegisterEffect(e4)
end
function c511002356.filter(c)
	return c:IsRace(RACE_WARRIOR) or c:IsSetCard(0x3008)
end
function c511002356.value(e,c)
	local ec=e:GetHandler():GetEquipTarget()
	if ec:IsCode(9327502) then
		return 1000
	else
		return 300
	end
end
