--Double Exposure
function c511009084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--double level
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(3606728,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e4:SetTarget(c511009084.tg1)
	e4:SetOperation(c511009084.op1)
	c:RegisterEffect(e4)
	--change name
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(97567736,1))
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e5:SetTarget(c511009084.tg2)
	e5:SetOperation(c511009084.op2)
	c:RegisterEffect(e5)
end
function c511009084.filter1(c,tp)
	return c:IsFaceup() and Duel.IsExistingTarget(c511009084.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetCode()) and c:IsLevelBelow(6)
end
function c511009084.filter2(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:IsLevelBelow(6) 
end
function c511009084.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009084.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511009084.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009084.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst(),g1:GetFirst():GetCode())
end
function c511009084.op1(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		e1:SetValue(tc:GetLevel()*2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511009084.filterB1(c)
	return c:IsFaceup() and Duel.IsExistingTarget(c511009084.filterB2,c:GetControler(),LOCATION_MZONE,0,1,c,c:GetCode()) 
end
function c511009084.filterB2(c,code)
	return c:IsFaceup() and not c:IsCode(code) 
end
function c511009084.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009084.filterB1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectTarget(tp,c511009084.filterB1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil):GetFirst()
	tc:RegisterFlagEffect(511009084,RESET_CHAIN,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009084.filterB2,tc:GetControler(),LOCATION_MZONE,0,1,1,tc,tc:GetCode())
end
function c511009084.op2(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()<=1 then return end
	local tc1=g:GetFirst()
	local tc2=g:GetNext()
	if tc2:GetFlagEffect(511009084)>0 then tc2,tc1=tc1,tc2 end
	if tc2:GetFlagEffect(511009084)>0 or tc1:GetFlagEffect(511009084)==0 then return end
	if tc1:IsFaceup() and tc2:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc2:GetCode())
		tc1:RegisterEffect(e1)
	end
end
