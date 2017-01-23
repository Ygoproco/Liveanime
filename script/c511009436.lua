--Constructive Destruction
function c511009436.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009436.target)
	e1:SetOperation(c511009436.activate)
	c:RegisterEffect(e1)
end
function c511009436.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x10af) 
		and Duel.IsExistingMatchingCard(c511009436.thfilter,tp,LOCATION_DECK,0,1,nil)
end
function c511009436.thfilter(c)
	return c:IsSetCard(0x10af) and c:IsAbleToHand()
end
function c511009436.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009436.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009436.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511009436.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511009436.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local g=Duel.SelectMatchingCard(tp,c511009436.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		local hc=g:GetFirst()
		if hc then
			Duel.SendtoHand(hc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,hc)
		end
		local tc=Duel.SelectMatchingCard(tp,c511009436.thfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
