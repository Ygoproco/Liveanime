--D - Hyper Nova
function c511009457.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetHintTiming(0,0x1e0)
	e1:SetCost(c511009457.cost)
	e1:SetTarget(c511009457.target)
	e1:SetOperation(c511009457.activate)
	c:RegisterEffect(e1)
end
function c511009457.filter(c)
	return c:IsSetCard(0xc008)
end
function c511009457.ctfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511009457.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and eg:IsExists(Card.IsControler,1,nil,1-tp)
	and Duel.IsExistingMatchingCard(c511009457.filter,tp,LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(c511009457.ctfilter,tp,0,LOCATION_MZONE,1,nil)
end
function c511009457.dfilter(c)
	return c:IsStatus(STATUS_SPSUMMON_TURN)
end
function c511009457.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009457.dfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511009457.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511009457.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009457.dfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
