--Pain to Power
function c511000052.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Gain ATK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCondition(c511000052.atkcon)
	e3:SetTarget(c511000052.atktg)
	e3:SetOperation(c511000052.atkop)
	c:RegisterEffect(e3)
end
function c511000052.atktg(e,c)
	return c~=e:GetHandler():GetEquipTarget()
end
function c511000052.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and bit.band(r,REASON_BATTLE)>0 and ep==tp
end
function c511000052.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511000052)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ev)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
