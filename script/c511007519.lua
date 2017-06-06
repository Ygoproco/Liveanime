--Cyber Ogre (Anime)
function c511007519.initial_effect(c)
	--Negate Battle & Gain ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64268668,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511007519.atkcon)
	e1:SetCost(c511007519.atkcost)
	e1:SetOperation(c511007519.atkop)
	c:RegisterEffect(e1)
end
function c511007519.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return ((a and a:IsControler(tp) and a:IsFaceup() and a==e:GetHandler())
		or (d and d:IsControler(tp) and d:IsFaceup() and d==e:GetHandler()))
end
function c511007519.cfilter(c)
	return c:IsCode(64268668) and c:IsDiscardable()
end
function c511007519.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511007519.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511007519.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c511007519.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a:IsRelateToBattle() or not d:IsRelateToBattle() then return end
	if e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() then
		Duel.NegateAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
	if a:GetControler()==tp and a==e:GetHandler() then
		e1:SetValue(d:GetAttack())
		e:GetHandler():RegisterEffect(e1)
	else
		e1:SetValue(a:GetAttack())
		e:GetHandler():RegisterEffect(e1)
	end
end
end