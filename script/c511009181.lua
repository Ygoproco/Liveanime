--Guidance to the Abyss
--fixed by MLD
function c511009181.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009181.condition)
	e1:SetTarget(c511009181.target)
	e1:SetOperation(c511009181.activate)
	c:RegisterEffect(e1)
end
function c511009181.cfilter(c)
	return (c:IsSetCard(0x437) or c:IsCode(12538374,51534754)) and c:IsType(TYPE_MONSTER)
end
function c511009181.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(c511009181.cfilter,tp,LOCATION_GRAVE,0,nil)==2
end
function c511009181.filter(c,e,tp)
	return (c:IsSetCard(0x437) or c:IsCode(12538374,51534754)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009181.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009181.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511009181.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009181.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
