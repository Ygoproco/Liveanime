--Miracle Rocket Show
function c511004420.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate destruction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_MONSTER))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage process
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511004420.condition)
	e3:SetOperation(c511004420.operation)
	c:RegisterEffect(e3)
	--end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c511004420.op)
	c:RegisterEffect(e4)
end
function c511004420.condition(e,tp,eg,ev,ep,re,r,rp)
	return tp==rp
end
function c511004420.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511004420)==0 then c:RegisterFlagEffect(511004420,RESET_PHASE+PHASE_BATTLE,0,1) end
	local dt=c:GetFlagEffectLabel(511004420)
	if not dt then dt=0 end
	dt=dt+Duel.GetBattleDamage(1-tp)
	c:SetFlagEffectLabel(511004420,dt)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e1:SetValue(0)
	Duel.RegisterEffect(e1,tp)
end
function c511004420.op(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Destroy(c,REASON_EFFECT)
	if c:GetFlagEffect(511004420)~=0 and c:GetFlagEffectLabel(511004420) then
		Duel.Damage(1-tp,c:GetFlagEffectLabel(511004420),REASON_EFFECT)
	end
end