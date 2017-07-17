-- Card Breaker (Anime)
-- scripted by: UnknownGuest
--fixed by MLD
function c810000050.initial_effect(c)
	-- spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	e1:SetCondition(c810000050.spcon)
	e1:SetOperation(c810000050.spop)
	c:RegisterEffect(e1)
end
function c810000050.spfilter(c,e)
	return c:GetSequence()<5 and c:IsDestructable(e)
end
function c810000050.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000050.spfilter,c:GetControler(),LOCATION_SZONE,LOCATION_SZONE,1,nil,e)
end
function c810000050.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c810000050.spfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,e)
	Duel.Destroy(g,REASON_COST)
end
