--Triangle Evolution
function c511003001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511003001.target)
	e1:SetOperation(c511003001.activate)
	c:RegisterEffect(e1)
end
function c511003001.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(5)
end
function c511003001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511003001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511003001.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511003001.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c511003001.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511003001)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BE_MATERIAL)
		e2:SetCondition(c511003001.effcon)
		e2:SetOperation(c511003001.effop)
		e2:SetReset(RESET_EVENT+0x17e0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c511003001.effcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c511003001.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511003001)
	local rc=e:GetHandler():GetReasonCard()
	local e1=Effect.CreateEffect(e:GetOwner())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(-1000)
	rc:RegisterEffect(e1,true)
end
