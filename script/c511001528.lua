--Darkness Half
function c511001528.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c511001528.filter,CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON,EFFECT_FLAG_DAMAGE_STEP,TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP,c511001528.condition,nil,c511001528.target,c511001528.operation)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.PersistentTargetFilter)
	e1:SetValue(c511001528.atkval)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001528.descon)
	e2:SetOperation(c511001528.desop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511001528.desop2)
	c:RegisterEffect(e3)
end
function c511001528.atkval(e,c)
	return c:GetBaseAttack()/2
end
function c511001528.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(1-tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001529,0,0x4011,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK)
end
function c511001528.cfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511001528.filter(c,e,tp)
	local atk=c:GetAttack()
	return c:IsFaceup() and not Duel.IsExistingMatchingCard(c511001528.cfilter,tp,LOCATION_MZONE,0,1,nil,atk)
end
function c511001528.target(e,tp,eg,ep,ev,re,r,rp,tc)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511001528.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=1 or Duel.IsPlayerAffectedByEffect(1-tp,59822133) 
		or not Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001529,0,0x4011,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK) then return end
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,511001529)
			Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511001528.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001528.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT)
end
function c511001528.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
