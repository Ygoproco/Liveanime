--Dragons Unite
function c511000355.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000355.value)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c511000355.value)
	c:RegisterEffect(e3)
end
function c511000355.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c511000355.value(e,c)
	return Duel.GetMatchingGroupCount(c511000355.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)*400
end
