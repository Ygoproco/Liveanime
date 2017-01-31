--D/D/D Wave High King Executive Caesar
function c511009532.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_FIEND),6,2)
	c:EnableReviveLimit()
	--disable spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(93016201,0))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	-- e4:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e4:SetCode(EVENT_CHAINING)
	e4:SetCondition(c511009532.condition3)
	e4:SetCost(c511009532.cost3)
	e4:SetTarget(c511009532.target3)
	e4:SetOperation(c511009532.activate3)
	c:RegisterEffect(e4)
	--Activate
	-- local e2=Effect.CreateEffect(c)
	-- e2:SetDescription(aux.Stringid(27769400,0))
	-- e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	-- e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	-- e2:SetCode(EVENT_CUSTOM+511009532)
	-- e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	-- e2:SetRange(LOCATION_MZONE)
	-- e2:SetCost(c511009532.cost)
	-- e2:SetTarget(c511009532.atktg)
	-- e2:SetOperation(c511009532.atkop)
	-- c:RegisterEffect(e2)
	--search
	-- local e3=Effect.CreateEffect(c)
	-- e3:SetDescription(aux.Stringid(3758046,1))
	-- e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	-- e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	-- e3:SetCode(EVENT_TO_GRAVE)
	-- e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	-- e3:SetCondition(c511009532.thcon)
	-- e3:SetTarget(c511009532.thtg)
	-- e3:SetOperation(c511009532.thop)
	-- c:RegisterEffect(e3)
end
-------------------------------------------------
function c511009532.condition3(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasCategory(CATEGORY_SPECIAL_SUMMON) and Duel.IsChainDisablable(ev)
end
function c511009532.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c511009532.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511009532.activate3(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
		Debug.Message(eg:GetFirst():GetCode())
	end
end

--------------------------------------------------
function c511009532.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf)
end
function c511009532.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009532.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009532.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009532.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009532.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ev)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
------------------------
function c511009532.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c511009532.thfilter(c)
	return c:IsSetCard(0xae) and c:IsAbleToHand()
end
function c511009532.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009532.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511009532.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511009532.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
