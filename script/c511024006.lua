--Xyz Shift (Anime)
--Scripter by IanxWaifu
function c511024006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c511024006.cost)
	e1:SetTarget(c511024006.target)
	e1:SetOperation(c511024006.activate)
	c:RegisterEffect(e1)
end
function c511024006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c511024006.cfilter(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsAbleToGraveAsCost() and Duel.IsExistingMatchingCard(c511024006.spfilter1,tp,LOCATION_EXTRA,0,1,nil,c,e,tp)
end
function c511024006.spfilter1(c,tc,e,tp)
	return c:GetRank()==tc:GetRank() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511024006.spfilter2(c,tc,e,tp)
	return c:GetRank()==tc:GetPreviousRankOnField() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511024006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
			and Duel.IsExistingMatchingCard(c511024006.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	e:SetLabel(0)
	local g=Duel.SelectMatchingCard(tp,c511024006.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	Duel.SendtoGrave(tc,REASON_COST)
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511024006.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511024006.spfilter2,tp,LOCATION_EXTRA,0,1,1,nil,tc,e,tp)
	local sc=g:GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		if c:IsRelateToEffect(e) then
			c:CancelToGrave()
			Duel.Overlay(sc,Group.FromCards(c))
		end
	end
end