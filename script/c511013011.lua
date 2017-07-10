--最強の盾
function c511013011.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR))
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511013011.atkval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c511013011.defval)
	c:RegisterEffect(e3)
end
function c511013011.atkval(e,c)
	if c:IsDefensePos() then return 0 else return c:GetDefense() end
end
function c511013011.defval(e,c)
	if c:IsAttackPos() then return 0 else return c:GetAttack() end
end
