--強欲な壺
--fixed by MLD
function c511777003.initial_effect(c)
	--Activate add to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511777003.target)
	e1:SetOperation(c511777003.activate)
	c:RegisterEffect(e1)
end
function c511777003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
	if chk==0 then return tc and tc:IsType(TYPE_SPELL) and tc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tc,1,0,0)
end
function c511777003.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)-1)
	if tc and tc:IsType(TYPE_SPELL) and tc:IsAbleToHand() and (aux.nvfilter(tc) or not Duel.IsChainDisablable(0)) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
