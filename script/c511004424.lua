--supreme king dance
function c511004424.initial_effect(c)
	local st1=aux.Stringid(4004,0)
	local st2=aux.Stringid(4004,1)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(st1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004424.condition1)
	e2:SetTarget(c511004424.target1)
	e2:SetOperation(c511004424.operation1)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511004424.reptg)
	e3:SetValue(c511004424.repval)
	c:RegisterEffect(e3)
	--attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(st2)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511004424.condition2)
	e4:SetCost(c511004424.cost)
	e4:SetTarget(c511004424.target2)
	e4:SetOperation(c511004424.operation2)
	c:RegisterEffect(e4)
end
function c511004424.filter0(c)
	return c:IsFaceup() and c:IsSetCard(0xf8)
end
function c511004424.condition1(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2 and Duel.IsExistingMatchingCard(c511004424.filter0,tp,LOCATION_MZONE,0,1,nil) and e:GetHandler():GetFlagEffect(511004424)==0
end
function c511004424.filter1(c,mode)
	return c:IsFaceup() and (mode==0 or (mode==1 and c:GetAttackAnnouncedCount()==0))
end
function c511004424.target1(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004424.filter1,tp,0,LOCATION_MZONE,1,nil,0) end
	local tg=Duel.SelectTarget(tp,c511004424.filter1,tp,0,LOCATION_MZONE,1,1,nil,0)
	e:GetHandler():RegisterFlagEffect(511004424,RESET_PHASE+PHASE_BATTLE,0,1)
end
function c511004424.operation1(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		if tc:GetAttackAnnouncedCount()~=0 then
			local e2=e1:Clone()
			e2:SetCode(EFFECT_EXTRA_ATTACK)
			e2:SetValue(1)
			tc:RegisterEffect(e2)
		end
		tc=tg:GetNext()
	end
end
function c511004424.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsSetCard(0xf8)
		and ((c:IsType(TYPE_MONSTER) and c:IsReason(REASON_BATTLE)) or (c:IsReason(REASON_EFFECT)))
end
function c511004424.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511004424.repfilter,1,nil,tp) end
	return true
end
function c511004424.repval(e,c)
	return c511004424.repfilter(c,e:GetHandlerPlayer())
end
function c511004424.condition2(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c511004424.cost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511004424.target2(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004424.filter1,tp,0,LOCATION_MZONE,1,nil,1) end
	local tg=Duel.GetMatchingGroup(c511004424.filter1,tp,0,LOCATION_MZONE,nil,1)
	Duel.SetTargetCard(tg)
	e:GetHandler():RegisterFlagEffect(511004424,RESET_PHASE+PHASE_BATTLE,0,1)
end
function c511004424.operation2(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MUST_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
		tc=tg:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_PATRICIAN_OF_DARKNESS)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_BATTLE)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
end
