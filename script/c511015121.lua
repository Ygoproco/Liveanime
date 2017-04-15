--Stronghold the Moving Fortress (Manga)
function c511015121.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511015121.condition)
	e1:SetTarget(c511015121.target)
	e1:SetOperation(c511015121.activate)
	c:RegisterEffect(e1)
	
	if not c511015121.global_check then
		c511015121.global_check=true
		--move to fzone
		local e2=Effect.CreateEffect(c)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_SSET)
		e2:SetOperation(c511015121.operation)
		Duel.RegisterEffect(e2,0)
	end
end
function c511015121.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()==nil
end
function c511015121.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511015121,0,0x21,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511015121.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not Duel.NegateAttack() then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511015121,0,0x21,0,2000,4,RACE_MACHINE,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_EFFECT)
	Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	--update attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(3000)
	e1:SetCondition(c511015121.atkcon)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1,true)
	Duel.SpecialSummonComplete()
end
function c511015121.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511015121.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c511015121.cfilter,tp,LOCATION_ONFIELD,0,1,nil,41172955)
		and Duel.IsExistingMatchingCard(c511015121.cfilter,tp,LOCATION_ONFIELD,0,1,nil,86445415)
		and Duel.IsExistingMatchingCard(c511015121.cfilter,tp,LOCATION_ONFIELD,0,1,nil,13839120)
end

function c511015121.codefilter(c,code)
	return c:GetOriginalCode()==code and c:GetSequence()<5
end
function c511015121.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511015121.codefilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil,511015121)
	local c=g:GetFirst()
	while c do
		local fc=Duel.GetFieldCard(c:GetControler(),LOCATION_SZONE,5)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
		end
		fc=Duel.GetFieldCard(1-c:GetControler(),LOCATION_SZONE,5)
		if fc and Duel.GetFlagEffect(c:GetControler(),62765383)>0 then
			if not Duel.Destroy(fc,REASON_RULE) then Duel.SendtoGrave(fc,REASON_RULE) end
		end
	
		Duel.MoveSequence(c,5)
		c=g:GetNext()
	end
end