--Transmigrating Life Force
function c511009541.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
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
	and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>3	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009541.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c511009541.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>3
		and Duel.IsExistingMatchingCard(c511009541.filter,tp,LOCATION_GRAVE,0,4,nil) end
	local g=Duel.SelectTarget(tp,c511009541.filter,tp,LOCATION_GRAVE,0,4,4,nil)	
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c511009541.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg or tg:FilterCount(Card.IsRelateToEffect,nil,e)~=4 or Duel.GetLocationCount(tp,LOCATION_SZONE)<4 then return end
	local tc=tg:GetFirst()
	while tc do
		if tc:IsRelateToEffect(e) and tc:IsSSetable() then
			Duel.SSet(tp,tc)
			Duel.ConfirmCards(1-tp,tc)
		end
	tc=tg:GetNext()
	end
end
