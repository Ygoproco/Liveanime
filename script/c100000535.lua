--Ragnarok
function c100000535.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000535,4))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000535.condition)
	e1:SetTarget(c100000535.target)
	e1:SetOperation(c100000535.operation)
	c:RegisterEffect(e1)
end
c100000535.card_code_list={46986414,92377303,38033121,30208479}
function c100000535.cfilter(c)
	return c:IsFaceup() and c:IsCode(46986414,92377303,38033121,30208479)
end
function c100000535.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000535.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end
function c100000535.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c100000535.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(c100000535.rmfilter,tp,0x13,0,1,nil) end
	local rg=Duel.GetMatchingGroup(c100000535.rmfilter,tp,0x13,0,nil)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,rg,rg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000535.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000535.rmfilter,tp,0x13,0,nil)
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)>0 then
		local dg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		if dg:GetCount()>0 then
			Duel.Destroy(dg,REASON_EFFECT)
		end
	end
end
