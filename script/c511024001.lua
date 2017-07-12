--Wroughtweiler (Anime)
--Scripted by IanxWaifu
--fixed by MLD
function c511024001.initial_effect(c)
	--Tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(542100001,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetTarget(c511024001.target)
	e1:SetOperation(c511024001.activate)
	c:RegisterEffect(e1)
end
function c511024001.filter(c,f,v)
	return f(c,v) and c:IsAbleToHand()
end
function c511024001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511024001.filter,tp,LOCATION_GRAVE,0,1,nil,Card.IsSetCard,0x3008)
		and Duel.IsExistingMatchingCard(c511024001.filter,tp,LOCATION_GRAVE,0,1,nil,Card.IsCode,24094653) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,2,tp,LOCATION_GRAVE)
end
function c511024001.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511024001.filter,tp,LOCATION_GRAVE,0,nil,Card.IsSetCard,0x3008)
	local g2=Duel.GetMatchingGroup(c511024001.filter,tp,LOCATION_GRAVE,0,nil,Card.IsCode,24094653)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.SendtoHand(sg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg1)
	end
end
