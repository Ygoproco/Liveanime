--Sargasso the D.D. Battlefield (Anime)
function c511247019.initial_effect(c)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511247019,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c511247019.damcon1)
	e2:SetTarget(c511247019.damtg1)
	e2:SetOperation(c511247019.damop1)
	c:RegisterEffect(e2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511247019.damcon2)
	e2:SetOperation(c511247019.damop2)
	c:RegisterEffect(e2)
end
function c511247019.damcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():GetSummonType()==SUMMON_TYPE_SPECIAL and eg:GetFirst():GetType()==TYPE_XYZ
end
function c511247019.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(eg:GetFirst():GetSummonPlayer())
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,eg:GetFirst():GetSummonPlayer(),500)
end
function c511247019.damop1(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		if not Duel.IsPlayerAffectedByEffect(p,37511832) then
			Duel.Damage(p,d,REASON_EFFECT)
		end
	end
end
function c511247019.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511247019.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511247019.cfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511247019.damop2(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetTurnPlayer()
	if not Duel.IsPlayerAffectedByEffect(p,37511832) then
		Duel.Hint(HINT_CARD,0,511247019)
		Duel.Damage(p,500,REASON_EFFECT)
	end
end
