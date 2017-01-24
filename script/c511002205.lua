-- Morphtronic Master Arm
function c511002205.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511002205.value)
	c:RegisterEffect(e2)
end
function c511002205.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x26)
end
function c511002205.value(e,c)
	return Duel.GetMatchingGroupCount(c511002205.filter,c:GetControler(),LOCATION_ONFIELD,0,nil)*300
end
