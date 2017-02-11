--Rank-Up Gravity
function c511004425.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511004425.conditionca)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c511004425.actlimit)
	c:RegisterEffect(e2)
	--banishu
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511004425.conditionb)
	e3:SetOperation(c511004425.operationb)
	c:RegisterEffect(e3)
	--SDestroy
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511004425.conditionsd)
	e4:SetOperation(c511004425.operationsd)
	c:RegisterEffect(e4)
	--activate
	if not c511004425.globalcheck then
		c511004425.globalcheck=true
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_SPSUMMON_SUCCESS)
		e1:SetOperation(c511004425.rumcheck)
		Duel.RegisterEffect(e1,0)
	end
end
function c511004425.rumcheck(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local rc=re:GetHandler()
	if rc:IsSetCard(0x95) then
		local ec=eg:GetFirst()
		while ec do
			ec:RegisterFlagEffect(511004425,RESET_EVENT+0x1fe0000,0,1,rc:GetType())
			ec=eg:GetNext()
		end
	end
end
function c511004425.filter(c)
	return c:IsType(TYPE_XYZ) and c:GetFlagEffect(511004425)~=0 and c:GetFlagEffectLabel(511004425)==TYPE_SPELL
end
function c511004425.conditionca(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004425.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004425.actlimit(e,c)
	return not c511004425.filter(c)
end
function c511004425.filterb(c)
	return c:IsType(TYPE_MONSTER) and c:GetAttackAnnouncedCount()==0 and c:IsAbleToRemove()
end
function c511004425.conditionb(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004425.filterb,tp,0,LOCATION_MZONE,1,nil) --and Duel.GetTurnPlayer()~=tp
end
function c511004425.operationb(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(c511004425.filterb,tp,0,LOCATION_MZONE,nil)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c511004425.conditionsd(e,tp,eg,ev,ep,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511004425.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004425.operationsd(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Destroy(c,REASON_EFFECT)
	local p=Duel.GetCurrentPhase()
	if p>=PHASE_BATTLE_START and p<PHASE_MAIN2 then
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
end