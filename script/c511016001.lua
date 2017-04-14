--逆転する運命
function c511016001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511016001.target)
	e1:SetOperation(c511016001.activate)
	c:RegisterEffect(e1)
end
function c511016001.filter(c)
	return c:GetFlagEffect(36690018)~=0
end
function c511016001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511016001.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511016001.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511016001.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local val=tc:GetFlagEffectLabel(36690018)
		tc:SetFlagEffectLabel(36690018,1-val)
		tc=g:GetNext()
	end
end
