--Odd-Eyes Fusion Gate
function c511015104.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511015104.cost)
	e1:SetTarget(c511015104.target)
	e1:SetOperation(c511015104.activate)
	c:RegisterEffect(e1)	
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	
	Duel.AddCustomActivityCounter(511015104,ACTIVITY_SPSUMMON,c511015104.counterfilter)
end
function c511015104.counterfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_PENDULUM)~=SUMMON_TYPE_PENDULUM
end
function c511015104.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c511015104.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(511015104,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c511015104.splimit)
	Duel.RegisterEffect(e1,tp)
end

function c511015104.filter1(c,e,tp)
	return c:IsCode(16178681) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015104.filter2(c,e,tp,mc1)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511015104.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(c,mc1),nil)
end
function c511015104.filter3(c,e,tp,m,f)
	return c:IsType(TYPE_FUSION) and c:IsType(TYPE_PENDULUM) and (not f or f(c)) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m)
end
function c511015104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mc1=Duel.GetFirstMatchingCard(c511015104.filter1,tp,LOCATION_EXTRA,0,nil,e,tp)
		return not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and mc1
			and Duel.IsExistingMatchingCard(c511015104.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp,mc1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local c1=Duel.SelectTarget(tp,c511015104.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	local c2=Duel.SelectTarget(tp,c511015104.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c1):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,Group:FromCards(c1,c2),2,0,0)
end
function c511015104.activate(e,tp,eg,ep,ev,re,r,rp)
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
		tc = Duel.SelectMatchingCard(tp,c511015104.filter3,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sg,nil):GetFirst()
		tc:SetMaterial(sg)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		
		--destroy
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetCondition(c511015104.descon)
		e1:SetCost(c511015104.descost)
		e1:SetOperation(c511015104.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
		e1:SetLabelObject(tc)
	end
	
	
end
function c511015104.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc and eg:IsContains(tc) 
end
function c511015104.thfilter(c)
	return c:IsAbleToHand() and c:IsCode(511015105)
end
function c511015104.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetLabelObject():IsReason(REASON_DESTROY) and Duel.IsExistingMatchingCard(c511015104.thfilter,tp,LOCATION_DECK,0,1,nil)
		and e:GetHandler():IsAbleToGrave() and Duel.SelectYesNo(tp,aux.Stringid(511015104,0)) then
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
		e:GetHandler():RegisterFlagEffect(511015104,RESET_EVENT+EVENT_CHAIN_END+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511015104.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511015104)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c511015104.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	end
end