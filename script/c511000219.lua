--Matter Leveller
function c511000219.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsCode,10992251))
	--Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetCondition(c511000219.condtion)
	e3:SetValue(c511000219.atkval)
	c:RegisterEffect(e3)
end
function c511000219.condtion(e)
	local eq=e:GetHandler():GetEquipTarget()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttacker()==eq and Duel.GetAttackTarget()~=nil 
		and Duel.GetAttackTarget():IsDefensePos()
end
function c511000219.atkval(e,c)
	return Duel.GetAttackTarget():GetDefense()+100
end
