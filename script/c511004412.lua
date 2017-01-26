--Predaplant Stapelia Worm
function c511004412.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511004412.disop)
	c:RegisterEffect(e1)
end
function c511004412.disop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasCategory(CATEGORY_ATKCHANGE) then
		Duel.NegateEffect(ev)
		Duel.Destroy(ev)
	end
end