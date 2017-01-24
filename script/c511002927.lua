--Gagagamirror
function c511002927.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002927.target)
	e1:SetOperation(c511002927.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511002927.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511002927.regop)
	c:RegisterEffect(e3)
end
function c511002927.filter(c,e,tp)
	return c:GetLevel()>0 and c:IsFaceup() and c:IsSetCard(0x54)
end
function c511002927.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511002927.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002927.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511002927.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002927.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
	end
end
function c511002927.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if not tc or not tc:IsLocation(LOCATION_MZONE) then 
		c:ResetFlagEffect(511000189)
		return
	end
	if c:GetFlagEffect(511000189)>0 and c:GetFlagEffect(511000189)~=tc:GetLevel() then
		c:ResetFlagEffect(511000189)
	end
	while c:GetFlagEffect(511000189)<tc:GetLevel() do
		c:RegisterFlagEffect(511000189,RESET_EVENT+0x1ff0000,0,0)
	end
end
