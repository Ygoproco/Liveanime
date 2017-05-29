--Split Guard
--cleaned up and fixed by MLD
function c511008502.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--prevent destruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCondition(c511008502.indcon)
	e2:SetValue(c511008502.indct)
	c:RegisterEffect(e2)
end
function c511008502.cfilter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(c511008502.cfilter2,tp,LOCATION_MZONE,0,1,c,c:GetCode())
end
function c511008502.cfilter2(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511008502.indcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c511008502.cfilter,tp,LOCATION_MZONE,0,2,nil,tp)
end
function c511008502.indct(e,re,r,rp)
	if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
		return 1
	else return 0 end
end
