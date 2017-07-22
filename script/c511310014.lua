--Bubble Barrier (Anime)
--AlphaKretin
--fixed by MLD
function c511310014.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511310014.target)
	c:RegisterEffect(e1)
	--reset
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511310014.target)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511310014.negop)
	c:RegisterEffect(e3)
end
function c511310014.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local g=c:GetCardTarget()
	if g then
		local tc=g:GetFirst()
		while tc do
			c:CancelCardTarget(tc)
			tc=g:GetNext()
		end
	end
end
function c511310014.filter(c,g)
	return c:IsFaceup() and (c:IsSetCard(0x9f) or c:IsSetCard(0xc6)) and c:IsAttackBelow(1500) 
		and (not g or not g:IsContains(c)) and not c:IsDisabled()
end
function c511310014.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetCardTarget()
	local ag=Duel.GetMatchingGroup(c511310014.filter,tp,LOCATION_MZONE,0,nil,g)
	if not c:IsDisabled() and ag:GetCount()>0 and Duel.SelectEffectYesNo(tp,c) then
		Duel.Hint(HINT_CARD,0,511310014)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		local sg=ag:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		c:SetCardTarget(sg:GetFirst())
		Duel.NegateAttack()
	end
end
