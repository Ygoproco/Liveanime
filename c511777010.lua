--暴君の威圧
function c511777010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511777010.operation)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511777010.etarget)
	e2:SetValue(c511777010.efilter)
	c:RegisterEffect(e2)
end
function c511777010.etarget(e,c)
	return (c:GetOwner()==e:GetHandlerPlayer()) and c:IsFaceup() and c:IsRace(RACE_DEVINE)
end
function c511777010.efilter(e,te)
	return te:IsActiveType(TYPE_TRAP) and te:GetOwner()~=e:GetOwner()
end
function c511777010.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetLabel(2)
	e1:SetLabelObject(tc)
	e1:SetCondition(c511777010.tgcon)
	e1:SetOperation(c511777010.tgop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	c:RegisterEffect(e1)
end
function c511777010.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511777010.tgop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct-1
	e:SetLabel(ct)
	if ct==0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end