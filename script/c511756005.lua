--Negate Attack
function c511756005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c511756005.condition)
	e1:SetOperation(c511756005.activate)
	c:RegisterEffect(e1)
end
function c511756005.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()~=nil
end
function c511756005.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
