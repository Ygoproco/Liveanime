--Magical Star Sword
function c511002010.initial_effect(c)
	aux.AddEquipProcedure(c)
	--tograve
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90434926,0))
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetTarget(c511002010.drtg)
	e3:SetOperation(c511002010.drop)
	c:RegisterEffect(e3)
end
function c511002010.damfil(c,tp)
	return c:IsControler(tp) and c:IsAbleToGrave() and c:IsType(TYPE_SPELL)
end
function c511002010.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511002010.damfil,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,eg,1,tp,LOCATION_HAND)
end
function c511002010.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	local dc=eg:Filter(c511002010.damfil,nil,tp):Select(tp,1,1,nil)
	if c:IsRelateToEffect(e) then
		Duel.SendtoGrave(dc,REASON_EFFECT)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(100)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		ec:RegisterEffect(e1)
	end
end
