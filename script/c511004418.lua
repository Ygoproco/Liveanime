--Time Chain
function c511004418.initial_effect(c)
	--ativate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511004418.condition)
	e1:SetOperation(c511004418.operation)
	c:RegisterEffect(e1)
	--end of damage step
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004418.con1)
	e2:SetOperation(c511004418.op1)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511004418.con2)
	e3:SetOperation(c511004418.op2)
	c:RegisterEffect(e3)
	c:SetTurnCounter(0)
end
function c511004418.condition(e,tp,eg,ev,ep,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp)
end
function c511004418.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	c:SetCardTarget(a)
	c:SetCardTarget(d)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	a:RegisterEffect(e1)
	local e2=e1:Clone()
	d:RegisterEffect(e2)
end
function c511004418.con1(e,tp,eg,ev,ep,re,r,rp)
	return e:GetHandler():GetFlagEffect(511004418)==0 and e:GetHandler():GetCardTarget():GetCount()>0
end
function c511004418.op1(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(511004418,RESET_EVENT+0x1fe0000,0,1)
	local ecg=c:GetCardTarget()
	local ecc=ecg:GetFirst()
	while ecc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,4)
		elseif Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()~=PHASE_STANDBY then
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,3)
		elseif Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()==PHASE_STANDBY then
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,3)
		else
			e1:SetReset(RESET_PHASE+PHASE_STANDBY,4)
		end
		ecc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		ecc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCondition(c511004418.kek)
		ecc:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCondition(c511004418.kek)
		e4:SetValue(1)
		ecc:RegisterEffect(e4)
		ecc=ecg:GetNext()
	end
end
function c511004418.kek(e)
	return true
end
function c511004418.con2(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511004418.op2(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==2 then Duel.Destroy(c,REASON_EFFECT) end
end