--Substitution Shield
--身代わりの盾
--  By Shad3
--cleaned and updated by MLD
function c511005074.initial_effect(c)
	aux.AddEquipProcedure(c)
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_ADD_TYPE)
	e1:SetValue(TYPE_EFFECT)
	c:RegisterEffect(e1)
	--Negate 1 attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511005074.negop)
	c:RegisterEffect(e3)
end
function c511005074.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if c:GetFlagEffect(511005074)==0 and tc and Duel.SelectYesNo(tep,aux.Stringid(4001,13)) then
		Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
		if not tc:IsDisabled() then
			Duel.NegateAttack()
		end
		c:RegisterFlagEffect(511005074,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	end
end
