--Big Bang Dragon Blow
function c170000196.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,110000110,46232525,1,true,true)
	aux.AddEquipProcedure(c)
	--Big Bang Attack!
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(170000196,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c170000196.cost)
	e2:SetTarget(c170000196.tar)
	e2:SetOperation(c170000196.act)
	c:RegisterEffect(e2)
end
function c170000196.hermos_filter(c)
	return c:IsCode(110000110)
end
function c170000196.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_DRAGON) end
    local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_DRAGON)
	Duel.Release(g,REASON_COST)
end
function c170000196.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c170000196.act(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsFaceup() then return end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
