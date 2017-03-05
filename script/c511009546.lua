--Thorn Fangs of Violet Poison
function c511009546.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009546.cost)
	e1:SetTarget(c511009546.target)
	e1:SetOperation(c511009546.operation)
	c:RegisterEffect(e1)
end
function c511009546.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end

function c511009546.filter(c,tp)
	return c:IsFaceup() and not c:IsCode(41209827)
		and 
	Duel.IsExistingMatchingCard(c511009546.filter2,tp,LOCATION_MZONE,0,1,c,c:GetAttack())
end
function c511009546.filter2(c,atk)
	return c:IsFaceup() and c:IsAttackAbove(atk) and c:IsCode(41209827)
end
function c511009546.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	
	local g=Duel.GetMatchingGroup(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	local dam=g1:GetSum(Card.GetAttack)
	if g:FilterCount(Card.IsControler,nil,1-tp)==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,dam)
	elseif g:FilterCount(Card.IsControler,nil,tp)==0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
	else
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,dam)
	end
end
function c511009546.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local dam=tg:Filter(Card.IsFaceup,nil):GetSum(Card.GetAttack)
	local g=Duel.GetMatchingGroup(c511009546.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tg)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)~=0 and dam>0 then
		local dg=Duel.GetOperatedGroup()
		Duel.BreakEffect()
		if dg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,tp),1,nil) then Duel.Damage(tp,dam,REASON_EFFECT,true) end
		if dg:IsExists(aux.FilterEqualFunction(Card.GetPreviousControler,1-tp),1,nil) then Duel.Damage(1-tp,dam,REASON_EFFECT,true) end
		Duel.RDComplete()
	end
end
