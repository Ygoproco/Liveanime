--Invalid Insensitive
function c511013006.initial_effect(c)
	--protect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000136.condition)
	e1:SetOperation(c511013006.operation)
	c:RegisterEffect(e1)
	--halve battle deamge
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511013006.hdcondition)
	e2:SetCost(c511013006.hdcost)
	e2:SetOperation(c511013006.hdoperation)
	c:RegisterEffect(e2)
	--selfdes
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511013006.destg)
	e3:SetOperation(c511013006.desop)
	c:RegisterEffect(e3)
end
function c511013006.cfilter(c)
	return c:IsOnField() and c:IsType(TYPE_MONSTER)
end
function c511013006.condition(e,tp,eg,ep,ev,re,r,rp)
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c511013006.cfilter,nil)-tg:GetCount()>0
end
function c511013006.operation(e,tp,eg,ep,ev,re,r,rp)
local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(c511013006.indval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511013006.indval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c511013006.hdcondition(e,tp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d~=nil and a:IsRelateToBattle() and d:IsRelateToBattle()
end
function c511013006.hdcost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511013006.hdoperation(e,tp)
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
function c511013006.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511013006.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
