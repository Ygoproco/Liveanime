--Cipher Chain
function c511018512.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511018512.condition)
	e1:SetTarget(c511018512.target)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511018512.descon)
	e2:SetOperation(c511018512.desop)
	c:RegisterEffect(e2)
end
function c511018512.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511018512.filter(c)
	return c:IsFaceup() and c:IsCanBeEffectTarget() and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511018512.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511018512.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511018512.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	end
	local g=Duel.GetMatchingGroup(c511018512.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
	c:SetCardTarget(tc)
	tc=g:GetNext()
	end
end
function c511018512.desfilter(c,sg,re,e)
	return sg:IsContains(c) and c:IsReason(REASON_DESTROY) and (not re or re:GetHandler()~=e:GetHandler())
end
function c511018512.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()==0 then return false end
	return c:GetCardTarget():IsExists(c511018512.desfilter,1,nil,eg,re,e)
end
function c511018512.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	local tc=g:GetFirst()
	local dam=0
	while tc do
		if tc:IsLocation(LOCATION_MZONE) and Duel.Destroy(tc,REASON_EFFECT) then
			local atk=tc:GetPreviousAttackOnField()
			if atk<0 then atk=0 end
			dam=dam+atk
		end
		tc=g:GetNext()
	end
	Duel.Damage(0,dam,REASON_EFFECT)
	Duel.Damage(1,dam,REASON_EFFECT)
end