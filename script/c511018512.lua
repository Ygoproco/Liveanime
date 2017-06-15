--Cipher Chain
--fixed by MLD
function c511018512.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511018512.condition)
	e1:SetTarget(c511018512.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetLabelObject(e1)
	e2:SetCondition(aux.PersistentTgCon)
	e2:SetOperation(c511018512.tgop)
	c:RegisterEffect(e2)
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
function c511018512.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return g:FilterCount(Card.IsCanBeEffectTarget,nil,e)==g:GetCount() end
	Duel.SetTargetCard(g)
end
function c511018512.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(re) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,re)
	local tc=g:GetFirst()
	while tc do
		c:SetCardTarget(tc)
		tc=g:GetNext()
	end
end
function c511018512.desfilter(c,sg)
	return sg:IsContains(c) and c:IsReason(REASON_DESTROY)
end
function c511018512.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()==0 then return false end
	return eg:IsExists(c511018512.desfilter,1,nil,c:GetCardTarget())
end
function c511018512.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget():Filter(Card.IsLocation,nil,LOCATION_MZONE)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dam=0
		local sg=Duel.GetOperatedGroup()
		local tc=sg:GetFirst()
		while tc do
			local atk=tc:GetPreviousAttackOnField()
			if atk<0 then atk=0 end
			dam=dam+atk
			tc=sg:GetNext()
		end
		Duel.Damage(tp,dam,REASON_EFFECT)
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
