--Magic Barier
function c511018003.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511018003.target)
	e1:SetOperation(c511018003.operation)
	c:RegisterEffect(e1)
end
function c511018003.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c511018003.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return c511018003.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511018003.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SelectTarget(tp,c511018003.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511018003.operation(e,tp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
--[[
	http://yugioh.wikia.com/wiki/Magic_Barrier
--]]