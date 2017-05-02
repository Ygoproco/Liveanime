--Potential Yell
function c511004399.initial_effect(c)
	--activate
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004399.target)
	e1:SetOperation(c511004399.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c511004399.handcon)
	c:RegisterEffect(e2)
end
function c511004399.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c511004399.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004399.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SelectTarget(tp,c511004399.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511004399.operation(e,tp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(511004399,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c511004399.handcon(tp)
	return tp~=Duel.GetTurnPlayer()
end