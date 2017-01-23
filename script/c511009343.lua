--The Phantom Knights of Possession
function c511009343.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009343.target)
	e1:SetOperation(c511009343.activate)
	c:RegisterEffect(e1)
end
function c511009343.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511009343.xyzfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and Duel.IsExistingTarget(c511009343.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c511009343.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009343.xyzfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009343.xyzfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009343.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009343.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc2=Duel.SelectMatchingCard(tp,c511009343.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil):GetFirst()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_RANK_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_LEVEL_FINAL)
		e2:SetValue(tc2:GetLevel())
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end
