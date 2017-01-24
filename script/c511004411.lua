--Photo Frame
function c511004411.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004411.target)
	e1:SetOperation(c511004411.operation)
	c:RegisterEffect(e1)
end
function c511004411.filter(c)
	return c:GetOriginalCode()~=511004411 and c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsFaceup() and c:CheckActivateEffect(true,true,true)~=nil
end
function c511004411.target(e,tp,eg,ev,ep,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511004411.filter,tp,0,LOCATION_SZONE,1,e:GetHandler()) end
	local g=Duel.SelectMatchingCard(tp,c511004411.filter,tp,0,LOCATION_SZONE,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if not tc then return end
	local te,eg,ep,ev,re,r,rp=tc:CheckActivateEffect(true,true,true)
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg and tg(e,tp,eg,ep,ev,re,r,rp,0) then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511004411.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	local code=te:GetHandler():GetOriginalCode()
	c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(code)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e1)
	if te:GetHandler():IsType(TYPE_SPELL) then
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_TYPE)
		e2:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		c:RegisterEffect(e2)
	end
end