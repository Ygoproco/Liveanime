--Spell Sanctuary
function c511000171.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511000171.activate)
	c:RegisterEffect(e1)
	--quick-play
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_BECOME_QUICK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_SZONE,LOCATION_HAND+LOCATION_SZONE)
	e2:SetTarget(c511000171.spfilter)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_ADD_TYPE)
	e3:SetValue(TYPE_QUICKPLAY)
	c:RegisterEffect(e3)
end
function c511000171.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511000171.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(c511000171.filter,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(24140059,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	local g2=Duel.GetMatchingGroup(c511000171.filter,1-tp,LOCATION_DECK,0,nil)
	if g2:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(24140059,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g2:Select(1-tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,sg)
	end
end
function c511000171.spfilter(e,c)
	return c:IsType(TYPE_SPELL)
end