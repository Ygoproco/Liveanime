--Magical Contract Door (Anime)
function c511247020.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511247020.cost)
	e1:SetTarget(c511247020.target)
	e1:SetOperation(c511247020.activate)
	c:RegisterEffect(e1)
end
function c511247020.filter(c)
	return c:IsAbleToHand()
end
function c511247020.costfilter(c)
	return c:IsType(TYPE_SPELL)
end
function c511247020.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511247020.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511247020,0))
	local ag=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND,0,1,1,nil,TYPE_SPELL)
	if ag:GetCount()>0 then
		Duel.SendtoHand(ag,1-tp,REASON_EFFECT)
		Duel.ConfirmCards(tp,ag)
		Duel.ShuffleHand(tp)
		Duel.ShuffleHand(1-tp)
	end
end
function c511247020.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511247020.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511247020.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511247020.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end