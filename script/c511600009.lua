--DDoS Attack
function c511600009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511600009.target)
	e1:SetOperation(c511600009.activate)
	c:RegisterEffect(e1)		
end
function c511600009.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:GetLevel()>0
end
function c511600009.cfilter(c)
	return c:IsAbleToGrave() and c:IsCode(511600009)
end
function c511600009.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511600009.filter(chkc) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(c511600009.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c511600009.cfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tg=Duel.SelectTarget(tp,c511600009.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511600009.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,c511600009.cfilter,tp,LOCATION_DECK,0,1,Duel.GetMatchingGroupCount(c511600009.cfilter,tp,LOCATION_DECK,0,nil),nil)
		if Duel.SendtoGrave(sg,REASON_EFFECT)~=0 then
			local og=Duel.GetOperatedGroup()
			local n=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
			local tc=Duel.GetFirstTarget()
			if tc:IsRelateToEffect(e) and tc:IsFaceup() and n>0 then
				Duel.Damage(1-tp,n*tc:GetLevel()*100,REASON_EFFECT)
			end
		end
	end
end