--Fossil Hammer
function c511001591.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001591.target)
	e1:SetOperation(c511001591.operation)
	c:RegisterEffect(e1)
end
function c511001591.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511001591.filter2(c,e,tp)
	return Duel.IsExistingMatchingCard(c511001591.spfilter,tp,0,LOCATION_GRAVE,1,nil,e,tp,c:GetLevel()-1)
end
function c511001591.spfilter(c,e,tp,lv)
	return c:IsLevelBelow(lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp) 
		and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001591.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511001591.filter,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetLevel)
	if chk==0 then return g:GetCount()>0 and tg and tg:IsExists(c511001591.filter2,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,tg:GetCount(),0,0)
end
function c511001591.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001591.filter,tp,0,LOCATION_MZONE,nil)
	local tg=g:GetMaxGroup(Card.GetLevel)
	if g:GetCount()==0 or not tg or not tg:IsExists(c511001591.filter2,1,nil,e,tp) then return end
	if Duel.Destroy(tg,REASON_EFFECT)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=Duel.SelectMatchingCard(1-tp,c511001591.spfilter,tp,0,LOCATION_GRAVE,1,1,nil,e,tp,g:GetFirst():GetLevel()-1)
		if sg2:GetCount()>0 then
			Duel.HintSelection(sg2)
			Duel.SpecialSummon(sg2,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
		end
	end
end
