--Hope Stairs
function c511009562.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009562.atcon)
	e2:SetOperation(c511009562.atkup)
	c:RegisterEffect(e2)
end
function c511009562.atcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	if d:IsControler(tp) then
		e:SetLabelObject(d)
		return a and d:IsRelateToBattle()
	elseif a:IsControler(tp) then
		e:SetLabelObject(a)
		return d and a:IsRelateToBattle() 
	end
	return false
end
function c511009562.atkup(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetValue(400)
		tc:RegisterEffect(e1)
	
end
