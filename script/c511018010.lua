--Gagaga Girl (anime)
function c511018010.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c511018010.con)
	e1:SetOperation(c511018010.op)
	e1:SetLabelObject(e0)
	c:RegisterEffect(e1)
end
function c511018010.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetHandler():GetReasonCard()
	local ecg=ec:GetMaterial()
	return ecg:GetCount()==2 and ecg:IsExists(Card.IsSetCard,1,c,0x54) and r==REASON_XYZ
end
function c511018010.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511018010.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetMatchingGroup(c511018010.filter,ep,0,LOCATION_MZONE,nil)
	local tc=nil
	if tg:GetCount()>1 then
		tc=tg:Select(ep,1,1,nil):GetFirst()
	elseif tg:GetCount()==1 then
		tc=tg:GetFirst()
	end
	if tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
