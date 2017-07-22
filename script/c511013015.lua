--Photon Veil
--fixed by MLD
function c511013015.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511013015.target)
	e1:SetOperation(c511013015.activate)
	c:RegisterEffect(e1)
end
function c511013015.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToDeck()
end
function c511013015.filter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c511013015.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511013015.tdfilter,tp,LOCATION_HAND,0,3,nil) 
		and Duel.IsExistingMatchingCard(c511013015.filter,tp,LOCATION_DECK,0,3,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,3,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,3,tp,LOCATION_DECK)
end
function c511013015.activate(e,tp,eg,ep,ev,re,r,rp)
	local tdg=Duel.GetMatchingGroup(c511013015.tdfilter,tp,LOCATION_HAND,0,nil)
	if tdg:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local tdsg=tdg:Select(tp,3,3,nil)
		if Duel.SendtoDeck(tdsg,nil,2,REASON_EFFECT)>2 then
			local thg=Duel.GetMatchingGroup(c511013015.filter,tp,LOCATION_DECK,0,nil)
			if thg:GetCount()>=3 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local thsg=thg:Select(tp,3,3,nil)
				Duel.BreakEffect()
				Duel.SendtoHand(thsg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,thsg)
			end
		end
	end
end
