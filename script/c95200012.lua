--Commande duel 12
function c95200012.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200012.target)
	e1:SetOperation(c95200012.operation)
	c:RegisterEffect(e1)
end
function c95200012.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,PLAYER_ALL,LOCATION_GRAVE)
end
function c95200012.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c95200012.operation(e,tp,eg,ep,ev,re,r,rp)
	--[[local p=Duel.RockPaperScissors()
	if Duel.GetLocationCount(p,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(p,c95200012.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,p)
	if g:GetCount()~=0 then
		Duel.SpecialSummon(g,0,p,p,false,false,POS_FACEUP)
	end]]
end
