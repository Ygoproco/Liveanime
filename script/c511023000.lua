--One-Eyed Skill Gainer
function c511023000.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(99000120))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511023000.cost)
	e1:SetTarget(c511023000.copytg)
	e1:SetOperation(c511023000.copyop)
	c:RegisterEffect(e1)
end
	function c511023000.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
	function c511023000.copyfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c511023000.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c511023000.copyfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511023000.copyfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511023000.copyfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511023000.copyop(e,tp,eg,ep,ev,re,r,rp)
	if tc and c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsType(TYPE_TOKEN) then
		local code=tc:GetOriginalCodeRule()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		if not tc:IsType(TYPE_TRAPMONSTER) then
			c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
		end
	end
end
