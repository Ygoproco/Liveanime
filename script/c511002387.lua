--ものマネ幻想師
function c511002387.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002387.target)
	e1:SetOperation(c511002387.operation)
	c:RegisterEffect(e1)
end
function c511002387.cfilter(c,e,tp,eg,ep,ev,re,r,rp)
	return not c:IsHasEffect(511001408) and not c:IsHasEffect(511001283) and c511002387.filter(c,e,tp,eg,ep,ev,re,r,rp)
end
function c511002387.filter(c,e,tp,eg,ep,ev,re,r,rp)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:CheckActivateEffect(false,false,false)~=nil
end
function c511002387.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) or chkc:IsLocation(LOCATION_MZONE) and chkc:GetControler()~=tp and c511002387.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002387.cfilter,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511002387.filter,tp,0,LOCATION_GRAVE,1,1,nil)
end
function c511002387.operation(e,tp,eg,ep,ev,re,r,rp)
 local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	if c:IsRelateToEffect(e) and not tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
	end
	if c:IsRelateToEffect(e) and tc:IsType(TYPE_EQUIP+TYPE_CONTINUOUS)  then
		local tpe=tc:GetType()
		local code=tc:GetOriginalCode()
		c:CopyEffect(code,nil,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetValue(tpe)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		c:RegisterEffect(e1)
		local te=tc:GetActivateEffect()
		local tg=te:GetTarget()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end 
		c:CancelToGrave()
	end
end
