--Odd-Eyes Xyz Gate
function c511015106.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511015106.cost)
	e1:SetTarget(c511015106.target)
	e1:SetOperation(c511015106.activate)
	c:RegisterEffect(e1)	
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
end

function c511015106.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c511015106.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c511015106.splimit)
	Duel.RegisterEffect(e1,tp)
end

function c511015106.filter1(c,e,tp)
	return c:IsCode(16178681) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015106.filter2(c,e,tp,mc1)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511015106.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,mc1)
end
function c511015106.filter3(c,e,tp,mXyz,mOdd)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_XYZ_LEVEL)
	e1:SetValue(7)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	mXyz:RegisterEffect(e1)

	local result = c511015106.filter4(c,e,tp,mXyz,mOdd)
	
	e1:Reset()
	
	return result
end
function c511015106.filter4(c,e,tp,mXyz,mOdd)
	return c:IsType(TYPE_XYZ) and c:IsType(TYPE_PENDULUM) and c:IsXyzSummonable(Group.FromCards(mXyz,mOdd),2,2)
end
function c511015106.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mc1=Duel.GetFirstMatchingCard(c511015106.filter1,tp,LOCATION_EXTRA,0,nil,e,tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and mc1
			and Duel.IsExistingMatchingCard(c511015106.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp,mc1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local c1=Duel.SelectTarget(tp,c511015106.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	local c2=Duel.SelectTarget(tp,c511015106.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c1):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,Group:FromCards(c1,c2),2,0,0)
end
function c511015106.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	
	if sg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
	local n = Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	if n==2 then
		local tc1 = sg:GetFirst()
		local tc2 = sg:GetNext()
				
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(7)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc2:RegisterEffect(e1)
		
		tc = Duel.SelectMatchingCard(tp,c511015106.filter4,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc2,tc1):GetFirst()
		Duel.XyzSummon(tp,tc,sg)
		
		--destroy
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetCondition(c511015106.descon)
		e1:SetOperation(c511015106.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
		e1:SetLabelObject(tc)
	
		--atk
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
		e2:SetCategory(CATEGORY_ATKCHANGE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCondition(c511015106.Atkcondition)
		e2:SetCost(c511015106.Atkcost)
		e2:SetOperation(c511015106.Atkoperation)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e2)
		e2:SetLabelObject(tc)
	end	
end
function c511015106.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc and eg:IsContains(tc) 
end
function c511015106.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end

function c511015106.banFilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511015106.Atkcondition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2 and Duel.GetTurnPlayer()==tp
end
function c511015106.Atkcost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c511015106.banFilter,tp,LOCATION_GRAVE,0,1,nil,511015104)
		and Duel.IsExistingMatchingCard(c511015106.banFilter,tp,LOCATION_GRAVE,0,1,nil,511015105) end
	local g1 = Duel.SelectMatchingCard(tp,c511015106.banFilter,tp,LOCATION_GRAVE,0,1,1,nil,511015104)
	g1:Merge(Duel.SelectMatchingCard(tp,c511015106.banFilter,tp,LOCATION_GRAVE,0,1,1,nil,511015105))
	g1:AddCard(e:GetHandler())
	Duel.Remove(g1,0,REASON_COST)
end
function c511015106.Atkoperation(e,tp,eg,ev,ep,re,r,rp)
	local tc=e:GetLabelObject()
	--Atk up
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(1000)
	tc:RegisterEffect(e1)				
	--Double Attack
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e2:SetValue(1)
	tc:RegisterEffect(e2)
end