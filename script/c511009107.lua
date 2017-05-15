--Performage Bubble Gardna
function c511009107.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetDescription(aux.Stringid(511001711,1))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_CAL)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009107.atkcon)
	e1:SetOperation(c511009107.atkop)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009107.reptg)
	e2:SetValue(c511009107.repval)
	c:RegisterEffect(e2)
end
function c511009107.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase~=PHASE_DAMAGE and phase~=PHASE_DAMAGE_CAL) or Duel.IsDamageCalculated() then return false end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local seq=e:GetHandler():GetSequence()
	local pc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	return d and ((a:GetControler()==tp and a:IsRelateToBattle() )
		or (d:GetControler()==tp and d:IsRelateToBattle())) and pc and pc:IsSetCard(0xc6)
end
function c511009107.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if Duel.GetTurnPlayer()~=tp then a=Duel.GetAttackTarget() end
	if not a:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511009107.rdop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511009107.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev/2)
	Duel.ChangeBattleDamage(1-tp,ev/2)
end
----destroy replace
function c511009107.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0xc6) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c511009107.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c511009107.repfilter,nil,e:GetHandlerPlayer())
	if chk==0 then return ct>0 end
	if Duel.SelectEffectYesNo(tp,e:GetHandler()) then
		return true
	else return false end
end
function c511009107.repval(e,c)
	return c511009107.repfilter(c,e:GetHandlerPlayer())
end