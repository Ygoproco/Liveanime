--Supreme King Wrath
--fixed by MLD
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
	c:RegisterEffect(e1)
	if not c511009537.global_check then
		c511009537.global_check=true
		c511009537[0]=0
		c511009537[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
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
function c511009537.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511009537.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END and c511009537[tp]>=2000 
		and Duel.IsExistingMatchingCard(c511009537.cfilter,tp,LOCATION_ONFIELD,0,1,nil,13331639)
end
function c511009537.desfilter(c)
	return c:IsFacedown() or not c:IsCode(13331639)
end
function c511009537.spfilter(c,g,ctchk,ect)
	local sg=g:Clone()
	local code=0
	if ctchk==0 then code=511009528
	elseif ctchk==1 then code=511009517
	elseif ctchk==2 then code=511009508
	elseif ctchk==3 then code=511009522
	else return false end
	if not c:IsCode(code) then return false end
	sg:Remove(Card.IsCode,nil,code)
	local ct=ect
	if ct and c:IsLocation(LOCATION_EXTRA) then
		ct=ct-1
		if ct==0 then sg:Remove(Card.IsLocation,nil,LOCATION_EXTRA) end
	end
	local ctc=ctchk+1
	return ctchk==3 or sg:IsExists(c511009537.spfilter,1,nil,sg,ctc,ct)
end
function c511009537.spfilterchk(c,e,tp,code)
	if not c:IsCanBeSpecialSummoned(e,0,tp,true,false) then return false end
	if code==nil then
		return c:IsCode(511009528,511009517,511009508,511009522)
	else
		return c:IsCode(code)
	end
end
function c511009537.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if chk==0 then
		if (Duel.GetLocationCount(tp,LOCATION_MZONE)<=3 and not Duel.IsExistingMatchingCard(c511009537.desfilter,tp,LOCATION_MZONE,0,1,nil)) 
			or Duel.IsPlayerAffectedByEffect(tp,59822133) then return false end
		if ect then
			local sg=Duel.GetMatchingGroup(c511009537.spfilterchk,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp)
			return sg:IsExists(c511009537.spfilter,1,nil,sg,0,ect)
		else
			return Duel.IsExistingMatchingCard(c511009537.spfilterchk,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009528) 
				and Duel.IsExistingMatchingCard(c511009537.spfilterchk,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009517) 
				and Duel.IsExistingMatchingCard(c511009537.spfilterchk,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009508) 
				and Duel.IsExistingMatchingCard(c511009537.spfilterchk,tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009522)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,tp,LOCATION_EXTRA+LOCATION_GRAVE)
end
function c511009537.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c511009537.desfilter,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(dg,REASON_EFFECT)>0 or dg:GetCount()==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
		local ok
		if ect then
			local sg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c511009537.spfilterchk),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,e,tp)
			ok=sg:IsExists(c511009537.spfilter,1,nil,sg,0,ect)
		else
			ok=Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c511009537.spfilterchk),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009528) 
				and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c511009537.spfilterchk),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009517) 
				and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c511009537.spfilterchk),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009508) 
				and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c511009537.spfilterchk),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,1,nil,e,tp,511009522)
		end
		if not ok then return end
		local loc=LOCATION_EXTRA+LOCATION_GRAVE
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511009537.spfilterchk),tp,loc,0,1,1,nil,e,tp,511009528)
		if ect and ect>1 and g1:GetFirst():IsLocation(LOCATION_EXTRA) then
			ect=ect-1
			if ect==0 then loc=LOCATION_GRAVE end
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511009537.spfilterchk),tp,loc,0,1,1,nil,e,tp,511009517)
		if ect and ect>1 and g2:GetFirst():IsLocation(LOCATION_EXTRA) then
			ect=ect-1
			if ect==0 then loc=LOCATION_GRAVE end
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g3=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511009537.spfilterchk),tp,loc,0,1,1,nil,e,tp,511009508)
		if ect and ect>1 and g3:GetFirst():IsLocation(LOCATION_EXTRA) then
			ect=ect-1
			if ect==0 then loc=LOCATION_GRAVE end
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g4=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511009537.spfilterchk),tp,loc,0,1,1,nil,e,tp,511009522)
		if ect and ect>1 and g4:GetFirst():IsLocation(LOCATION_EXTRA) then
			ect=ect-1
			if ect==0 then loc=LOCATION_GRAVE end
		end
		g1:Merge(g2)
		g1:Merge(g3)
		g1:Merge(g4)
		local tc=g1:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc=g1:GetNext()
		end
		Duel.SpecialSummonComplete()
		local og=Duel.GetMatchingGroup(aux.NecroValleyFilter(Card.IsCode),tp,LOCATION_EXTRA+LOCATION_GRAVE,0,nil,69610326)
		local drg=Duel.GetMatchingGroup(c511009537.cfilter,tp,LOCATION_MZONE,0,nil,511009508)
		if og:GetCount()>1 and drg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(12744567,0)) then
			Duel.BreakEffect()
			if drg:GetCount()>1 then
				drg=drg:Select(tp,1,1,nil)
			end
			Duel.HintSelection(drg)
			local sog=og:Select(tp,2,2,nil)
			Duel.Overlay(drg:GetFirst(),sog)
		end
	end
end
