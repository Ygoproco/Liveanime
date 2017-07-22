--タスケルトン
--Bacon Saver
--fixed by MLD
function c511013031.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95360850,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c511013031.atktg)
	e1:SetOperation(c511013031.atkop)
	c:RegisterEffect(e1)
end
function c511013031.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if not a then return false end
	local g=Group.FromCards(a,Duel.GetAttackTarget())
	if chk==0 then return g:IsExists(Card.IsControler,1,nil,tp) end
	local sg=g:Filter(Card.IsControler,nil,tp)
	Duel.SetTargetCard(sg)
end
function c511013031.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
