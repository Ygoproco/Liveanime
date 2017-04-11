-- Zeus' Breath
-- scripted by: UnknownGuest
--fixed by MLD
function c810000019.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c810000019.condition)
	e1:SetTarget(c810000019.target)
	e1:SetOperation(c810000019.activate)
	c:RegisterEffect(e1)
end
function c810000019.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c810000019.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c810000019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() end
	if Duel.IsExistingMatchingCard(c810000019.cfilter,tp,LOCATION_MZONE,0,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
	end
end
function c810000019.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
	if Duel.IsExistingMatchingCard(c810000019.cfilter,tp,LOCATION_MZONE,0,1,nil) then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
