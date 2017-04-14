--デステニー・デストロイ
function c511001910.initial_effect(c)
	--discard deck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001910.target)
	e1:SetOperation(c511001910.activate)
	c:RegisterEffect(e1)
end
function c511001910.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_DECK,0,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,5,tp,LOCATION_DECK)
end
function c511001910.filter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_SPELL)
end
function c511001910.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,5,5,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
		local dg=Duel.GetOperatedGroup()
		local ct=dg:FilterCount(c511001910.filter,nil)
		if ct>0 then
			Duel.Damage(tp,ct*100,REASON_EFFECT)
		end
	end
end
