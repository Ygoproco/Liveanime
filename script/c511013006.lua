--Invalid Insensitive
--fixed by MLD
function c511013006.initial_effect(c)
	--protect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511013006.condition)
	e1:SetOperation(c511013006.activate)
	c:RegisterEffect(e1)
	--halve battle deamge
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511013006.hdcon)
	e2:SetCost(c511013006.hdcost)
	e2:SetOperation(c511013006.hdop)
	c:RegisterEffect(e2)
	--selfdes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511013006.desop)
	c:RegisterEffect(e3)
end
function c511013006.condition(e,tp,eg,ep,ev,re,r,rp)
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsType,nil,TYPE_MONSTER)-tg:GetCount()>0
end
function c511013006.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511013006.hdcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	return Duel.GetAttacker():IsRelateToBattle()
end
function c511013006.hdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511013006.hdop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511013006.rdop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511013006.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,Duel.GetBattleDamage(tp)/2)
	Duel.ChangeBattleDamage(1-tp,Duel.GetBattleDamage(1-tp)/2)
end
function c511013006.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
