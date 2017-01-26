--Phoenix Battle Wing
function c511000745.initial_effect(c)
	aux.AddEquipProcedure(c)
	--des rep
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511000745.reptg)
	e3:SetOperation(c511000745.repop)
	c:RegisterEffect(e3)
end
function c511000745.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:GetEquipTarget() end
	if Duel.SelectYesNo(tp,aux.Stringid(511000745,0)) then
		return true
	else
		return false
	end
end
function c511000745.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetValue(c511000745.atkval)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c511000745.atkval(e,c)
	return c:GetAttack()*2
end
