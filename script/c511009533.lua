--En Flowers
--fixed by MLD
function c511009533.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--eff
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1353770,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009533.condition)
	e2:SetTarget(c511009533.target)
	e2:SetOperation(c511009533.operation)
	c:RegisterEffect(e2)
end
function c511009533.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code) and c:GetSequence()<5
end
function c511009533.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009533.cfilter,tp,LOCATION_SZONE,0,1,nil,511009534)
		and Duel.IsExistingMatchingCard(c511009533.cfilter2,tp,LOCATION_SZONE,0,1,nil,511009535)
		and Duel.IsExistingMatchingCard(c511009533.cfilter3,tp,LOCATION_SZONE,0,1,nil,511009536)
end
function c511009533.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.disfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(aux.disfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009533.filter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c511009533.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.disfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		if tc:RegisterEffect(e1)>0 and tc:RegisterEffect(e2)>0 then
			tc:RegisterFlagEffect(511009533,RESET_CHAIN,0,0)
		end
		tc=g:GetNext()
	end
	g=g:Filter(function(c) return c:GetFlagEffect(511009533)>0 end,nil)
	if Duel.Destroy(g,REASON_EFFECT)<=0 then return end
	local ct1=g:FilterCount(c511009533.filter,nil,tp)
	local ct2=g:FilterCount(c511009533.filter,nil,1-tp)
	Duel.BreakEffect()
	Duel.Damage(tp,ct1*600,REASON_EFFECT,true)
	Duel.Damage(1-tp,ct2*600,REASON_EFFECT,true)
	Duel.RDComplete()
end
