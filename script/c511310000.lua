--Chiron the Mage (Anime)
--AlphaKretin
function c511310000.initial_effect(c)
	--destroy facedown s/t
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16956455,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511310000.destg)
	e1:SetOperation(c511310000.desop)
	c:RegisterEffect(e1)
end
function c511310000.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c511310000.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsPosition(POS_FACEDOWN)
end
function c511310000.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c511310000.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511310000.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511310000.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511310000.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFacedown() then
		Duel.ConfirmCards(tp,tc)
	end
	if tc:IsRelateToEffect(e) and Duel.SelectYesNo(tp,aux.Stringid(1953925,0)) then --"Destroy", from Ancient Gear Engineer
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
