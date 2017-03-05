--Supreme King Wrath
function c511009537.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c511009537.condition)
	e1:SetTarget(c511009537.target)
	e1:SetOperation(c511009537.activate)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	if not c511009537.global_check then
		c511009537.global_check=true
		c511009537[0]=0
		c511009537[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetOperation(c511009537.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511009537.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009537.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511009537[ep]=c511009537[ep]+ev
end
function c511009537.clear(e,tp,eg,ep,ev,re,r,rp)
	c511009537[0]=0
	c511009537[1]=0
end
function c511009537.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and and Duel.IsExistingMatchingCard(c511009522.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511009537.filter(c,e,tp)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009537.spfilter1(c,e,tp)
	return c:IsCode(511009508) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c511009537.spfilter2,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,c,e,tp)
end
function c511009537.spfilter2(c,e,tp)
	return c:IsCode(511009517) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and Duel.IsExistingMatchingCard(c511009537.spfilter3,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,c,e,tp)
end
function c511009537.spfilter3(c,e,tp)
	return c:IsCode(511009522) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and Duel.IsExistingMatchingCard(c511009537.spfilter4,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,c,e,tp)
end
function c511009537.spfilter4(c,e,tp)
	return c:IsCode(511009528) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009537.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=c511009537[tp]
	local dct=math.floor(ct/1000)
	if chk==0 then return ct>=2000 and Duel.GetLocationCount(tp,LOCATION_MZONE)>3
		and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511009537.spfilter1,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp) 
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c511009537.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2
		or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 or sg:GetCount()==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c511009537.spfilter1,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c511009537.spfilter2,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
		g1:Merge(g2)
		local g3=Duel.SelectMatchingCard(tp,c511009537.spfilter3,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
		g1:Merge(g3)
		local g4=Duel.SelectMatchingCard(tp,c511009537.spfilter4,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
		g1:Merge(g4)
		if g1:GetCount()==4 then
			local tc=g:GetFirst()
		while tc do
			if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_DISABLE)
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
			end
			tc=g:GetNext()
		end
		Duel.SpecialSummonComplete()
		if Duel.IsExistingMatchingCard(c511009537.spfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511009537.spfilter1,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,2,nil,e,tp) then
			local gov1=Duel.SelectMatchingCard(tp,c511009443.thfil,tp,LOCATION_MZONE,0,1,1,nil)
				if gov1:GetCount()>0 then		
					local gov2=Duel.SelectMatchingCard(tp,c511009443.thfil,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,2,2,nil)
					if gov2:GetCount()>=2 then
						Duel.Overlay(gov1:GetFirst(),gov2)
					end
				end
			end
		end
	end
end
function c511009537.ovfilter1(c,e,tp)
	return c:IsFaceup() and c:IsCode(511009508)
end
function c511009537.ovfilter2(c,e,tp)
	return c:IsCode(69610326) 
end