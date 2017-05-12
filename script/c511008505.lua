-- Pollice Verso
function c511008505.initial_effect(c)
	-- Activate (only if you control 1 'Gladiator Beast)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511008505.actcondition)
	c:RegisterEffect(e1)
	-- If a card(s) is destroyed, its controller takes damage.
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511008505.damagecondition)
	e2:SetOperation(c511008505.damageoperation)
	c:RegisterEffect(e2)
end
function c511008505.actcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511008505.filterBySetCard,tp,LOCATION_MZONE,0,1,nil)
end
function c511008505.filterBySetCard(c)
	return c:IsFaceup() and c:IsSetCard(0x19)
end
function c511008505.damagecondition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511008505.filterCardDestroyed, 1, nil)
end
function c511008505.filterCardDestroyed(c)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c511008505.filterIsPControler(c,tp)
	return c:GetPreviousControler()==tp
end
function c511008505.damageoperation(e,tp,eg,ep,ev,re,r,rp)
	local dmgOpponent = eg:FilterCount (c511008505.filterIsPControler, nil, 1-tp)*500
	local dmgYou	  = eg:FilterCount (c511008505.filterIsPControler, nil, tp)*500
	Duel.Damage (tp,   dmgYou,  REASON_EFFECT, true)
	Duel.Damage (1-tp, dmgOpponent, REASON_EFFECT, true)
	Duel.RDComplete()	
end
