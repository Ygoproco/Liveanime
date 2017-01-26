--Heroic Growth
function c511002495.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR))
	--Atk Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetCondition(c511002495.condition)
	e2:SetValue(c511002495.value)
	c:RegisterEffect(e2)
end
function c511002495.condition(e)
	return Duel.GetLP(0)~=Duel.GetLP(1)
end
function c511002495.value(e,c)
	local p=e:GetHandler():GetControler()
	if Duel.GetLP(p)<Duel.GetLP(1-p) then
		return c:GetAttack()*2
	elseif Duel.GetLP(p)>Duel.GetLP(1-p) then
		return c:GetAttack()/2
	end
end
