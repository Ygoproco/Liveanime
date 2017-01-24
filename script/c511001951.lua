--Bee Force Nest
function c511001951.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c511001951.filter,nil,nil,nil,TIMING_MAIN_END+TIMING_BATTLE_START)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001951.descon)
	e2:SetOperation(c511001951.desop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93238626,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetLabel(2)
	e3:SetCondition(c511001951.spcon)
	e3:SetTarget(c511001951.sptg)
	e3:SetOperation(c511001951.spop)
	c:RegisterEffect(e3)
end
function c511001951.filter(c)
	return c:IsSetCard(0x214) and c:IsLevelBelow(2) and c:IsFaceup()
end
function c511001951.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001951.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511001951.spcon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	local tc=e:GetHandler():GetFirstCardTarget()
	return d and tc and (d==tc or d:IsCode(tc:GetCode()))
end
function c511001951.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001951.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetFirstCardTarget()
	if chk==0 then return tc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001951.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp,tc:GetCode()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001951.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001951.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp,tc:GetCode())
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		local ct=e:GetLabel()
		ct=ct-1
		e:SetLabel(ct)
		if ct<=0 then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
