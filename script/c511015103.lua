--D/D/D Xyz
function c511015103.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015103.target)
	e1:SetOperation(c511015103.activate)
	c:RegisterEffect(e1)
end
function c511015103.filter(c,e,tp)
	return c:IsSetCard(0x10af) and c:IsType(TYPE_PENDULUM) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015103.xyzfilter(c,e,mg)
	if mg:IsExists(Card.IsCode,1,nil,47198668) then
		local tc = mg:Filter(Card.IsCode,nil,47198668):GetFirst()
		--
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511001225)
		tc:RegisterEffect(e1)
	end
	return c:IsXyzSummonable(mg)
end

function c511015103.mfilter1(c,e,mg,exg,ft)
	return mg:IsExists(c511015103.mfilter2,1,nil,e,Group.FromCards(c),exg) and (ft>1 or c:IsCode(47198668))
end
function c511015103.mfilter2(c,e,mg,exg)
	local g = mg:Clone()
	g:AddCard(c)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,g,g:GetCount(),g:GetCount())
end
function c511015103.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c511015103.filter,tp,LOCATION_GRAVE+LOCATION_EXTRA,0,nil,e,tp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and ft>1 then ft=1 end
	local exg=Duel.GetMatchingGroup(c511015103.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,mg)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,1) and ft>0 and exg:GetCount()>0 
		and mg:IsExists(c511015103.mfilter1,1,nil,e,mg,exg,ft)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg1=mg:FilterSelect(tp,c511015103.mfilter1,1,1,nil,e,mg,exg,ft)
	mg:RemoveCard(sg1:GetFirst())
	local tc1=sg1:GetFirst()
	local continue = sg1:GetCount()<ft
	if exg:IsExists(Card.IsXyzSummonable,1,nil,sg1,sg1:GetCount(),sg1:GetCount())
		and mg:IsExists(c511015103.mfilter2,1,nil,e,sg1,exg) and continue then
		
		continue = Duel.SelectYesNo(tp,aux.Stringid(511015103,0))
	end
	while sg1:GetCount()<ft and mg:GetCount()>0 and continue do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=mg:FilterSelect(tp,c511015103.mfilter2,1,1,nil,e,sg1,exg)
		if not sg2 or sg2:GetCount()==0 then break end
		mg:RemoveCard(sg2:GetFirst())
		sg1:Merge(sg2)
		
		if not mg:IsExists(c511015103.mfilter2,1,nil,e,sg1,exg) then
			continue = false
		elseif not exg:IsExists(Card.IsXyzSummonable,1,nil,sg1,sg1:GetCount(),sg1:GetCount()) then
			continue = true;
		elseif sg1:GetCount()<ft then 		
			continue = Duel.SelectYesNo(tp,aux.Stringid(511015103,0)) 
		end
	end
	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg1,sg1:GetCount(),0,0)
end
function c511015103.filter2(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015103.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511015103.filter2,nil,e,tp)
	if g:GetCount()<1 or g:GetCount()>Duel.GetLocationCount(tp,LOCATION_MZONE) then return end
	local tc=g:GetFirst()
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
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	local xyzg=Duel.GetMatchingGroup(c511015103.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,g)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end
