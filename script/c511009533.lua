--En Flowers
function c511009533.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1353770,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c511009533.condition)
	e1:SetTarget(c511009533.target)
	e1:SetOperation(c511009533.operation)
	c:RegisterEffect(e1)
end
function c511009533.cfilter1(c)
	return c:IsFaceup() and c:IsCode(511009534)
end
function c511009533.cfilter2(c)
	return c:IsFaceup() and c:IsCode(511009535)
end
function c511009533.cfilter3(c)
	return c:IsFaceup() and c:IsCode(511009536)
end
function c511009533.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009533.cfilter1,tp,LOCATION_SZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(c511009533.cfilter2,tp,LOCATION_SZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(c511009533.cfilter3,tp,LOCATION_SZONE,0,1,nil)
end
function c511009533.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g1=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local sg=g1:Clone()
	sg:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,g1:GetCount()*600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g2:GetCount()*600)
end
function c511009533.filter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c511009533.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.Destroy(g,REASON_EFFECT)
	local ct1=g:FilterCount(c511009533.filter,nil,tp)
	local ct2=g:FilterCount(c511009533.filter,nil,1-tp)
	Duel.BreakEffect()
	Duel.Damage(tp,ct1*600,REASON_EFFECT)
	Duel.Damage(1-tp,ct2*600,REASON_EFFECT)
	
end
