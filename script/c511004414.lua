--Protector Adoration
function c511004414.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004414.target)
	e1:SetOperation(c511004414.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511004414.descon)
	e2:SetOperation(c511004414.desop)
	c:RegisterEffect(e2)
	--disable+attack_all
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511004414.distg)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e4:SetCode(EFFECT_ATTACK_ALL)
	e4:SetValue(c511004414.atkfilter)
	c:RegisterEffect(e4)
	--destroy 2
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511004414.desucon)
	e5:SetOperation(c511004414.desuop)
	c:RegisterEffect(e5)
end
function c511004414.desucon(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetFirstCardTarget()
	if not ec then return false end
	local chkg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,511009337)
	local ecg=ec:GetAttackedGroup()
	local ecc=ecg:GetFirst()
	while ecc do
		if chkg:IsContains(ecc) then RemoveCard(ecc) end
		ecc=ecg:GetNext()
	end
	return chkg:GetCount()>0
end
function c511004414.desuop(e,tp,eg,ev,ep,re,r,rp)
	local ec=e:GetHandler():GetFirstCardTarget()
	Duel.Destroy(ec,REASON_EFFECT)
end
function c511004414.distg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511004414.activatefilter(c)
	return c:GetSummonLocation()==LOCATION_EXTRA and c:IsType(TYPE_MONSTER)
end
function c511004414.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004414.activatefilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local tg=Duel.SelectTarget(tp,c511004414.activatefilter,tp,0,LOCATION_ONFIELD,1,1,nil)
end
function c511004414.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	c:SetCardTarget(tg)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and Duel.IsPlayerCanSpecialSummonMonster(tp,511009337,0,41,0,0,1,RACE_WARRIOR,ATTRIBUTE_LIGHT) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,511009337)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511004414.atkfilter(e,c)
	return c:IsCode(511009337)
end
function c511004414.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511004414.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
--[[
	token id=511009337
--]]