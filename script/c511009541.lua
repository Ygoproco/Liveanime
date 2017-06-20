--Transmigrating Life Force
--fixed by MLD
function c511009541.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009541.cost)
	e1:SetTarget(c511009541.target)
	e1:SetOperation(c511009541.activate)
	c:RegisterEffect(e1)
end
function c511009541.cfilter(c)
	return not c:IsAbleToGraveAsCost()
end
function c511009541.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsExistingMatchingCard(c511009541.cfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>3 end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009541.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c511009541.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511009541.filter(chkc) end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then
		ft=ft-1
	end
	if chk==0 then return ft>3 and Duel.IsExistingTarget(c511009541.filter,tp,LOCATION_GRAVE,0,4,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectTarget(tp,c511009541.filter,tp,LOCATION_GRAVE,0,4,4,nil)	
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,4,0,0)
end
function c511009541.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()<=0 or Duel.GetLocationCount(tp,LOCATION_SZONE)<g:GetCount() then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SSet(tp,tc)
		Duel.ConfirmCards(1-tp,tc)
		tc=g:GetNext()
	end
end
