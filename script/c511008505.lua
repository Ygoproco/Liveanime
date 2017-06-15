-- Pollice Verso
--cleaned up by MLD
function c511008505.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511008505.condition)
	c:RegisterEffect(e1)
	-- If a card(s) is destroyed, its controller takes damage.
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511008505.damcon)
	e2:SetOperation(c511008505.damop)
	c:RegisterEffect(e2)
end
function c511008505.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19)
end
function c511008505.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511008505.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511008505.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsReason,1,nil,REASON_BATTLE+REASON_EFFECT)
end
function c511008505.damfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetPreviousControler()==tp
end
function c511008505.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam1=eg:FilterCount(c511008505.damfilter,nil,tp)*500
	local dam2=eg:FilterCount(c511008505.damfilter,nil,1-tp)*500
	Duel.Damage(tp,dam1,REASON_EFFECT,true)
	Duel.Damage(1-tp,dam2,REASON_EFFECT,true)
	Duel.RDComplete()	
end
