--Mirror Force (anime)
--Scripted by edo9300
function c513000001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c513000001.condition)
	e1:SetTarget(c513000001.target)
	e1:SetOperation(c513000001.activate)
	c:RegisterEffect(e1)
end
function c513000001.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c513000001.filter(c,atk)
	return c:IsAttackPos() and c:GetAttack()<=atk
end
function c513000001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000001.filter,tp,0,LOCATION_MZONE,1,nil,Duel.GetAttacker():GetAttack()) end
	local g=Duel.GetMatchingGroup(c513000001.filter,tp,0,LOCATION_MZONE,nil,Duel.GetAttacker():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c513000001.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c513000001.filter,tp,0,LOCATION_MZONE,nil,Duel.GetAttacker():GetAttack())
	local a=Duel.GetAttacker()
	g:RemoveCard(a)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.HintSelection(Group.FromCards(tc))
			Duel.Damage(1-tp,a:GetAttack()-tc:GetAttack(),REASON_EFFECT)
			Duel.Destroy(tc,REASON_EFFECT)
			tc=g:GetNext()
		end
	end
	Duel.Destroy(a,REASON_EFFECT)
end
