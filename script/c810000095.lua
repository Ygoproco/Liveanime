--Magical Academy
--scripted by: UnknownGuest
--fixed by MLD
function c810000095.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE+TIMING_SUMMON)
	e1:SetCost(c810000095.cost)
	e1:SetTarget(c810000095.target)
	e1:SetOperation(c810000095.activate)
	c:RegisterEffect(e1)
end
function c810000095.cfilter1(c,e,tp)
	return c:IsDiscardable() and Duel.IsExistingMatchingCard(c810000095.cfilter2,tp,LOCATION_HAND,0,1,c,e,tp,c)
end
function c810000095.cfilter2(c,e,tp,c2)
	return c:IsDiscardable() and Duel.IsExistingMatchingCard(c810000095.filter,tp,LOCATION_HAND,0,1,nil,e,tp,c2,c)
end
function c810000095.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000095.cfilter1,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g1=Duel.SelectMatchingCard(tp,c810000095.cfilter1,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g2=Duel.SelectMatchingCard(tp,c810000095.cfilter2,tp,LOCATION_HAND,0,1,1,g1:GetFirst(),e,tp,g1:GetFirst())
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_DISCARD+REASON_COST)
end
function c810000095.filter(c,e,tp,c2,c3)
	if c==c2 or c==c3 then return false end
	if not c:IsRace(RACE_SPELLCASTER) or not c:IsSummonableCard() or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return false end
	--local mi,ma=c:GetTributeRequirement()
	local mi,ma
	if c:GetLevel()<=4 then mi,ma=0,0
	elseif c:GetLevel()>=7 then mi,ma=2,2
	else mi,ma=1,1 end
	return (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mi==0) or (ma>=mi and ma>0 and Duel.CheckTribute(c,mi))
end
function c810000095.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000095.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c810000095.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c810000095.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if tc then
		--local mi,ma=c:GetTributeRequirement()
		local mi,ma
		if tc:GetLevel()<=4 then mi,ma=0,0
		elseif tc:GetLevel()>=7 then mi,ma=2,2
		else mi,ma=1,1 end
		if mi>0 then
			local g=Duel.SelectTribute(tp,tc,mi,ma)
			Duel.Release(g,REASON_EFFECT)
		end
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(500)
		tc:RegisterEffect(e2,true)
		--disable
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_DISABLE)
		e3:SetTargetRange(0,LOCATION_SZONE)
		e3:SetTarget(c810000095.distg)
		e3:SetLabelObject(tc)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetCode(EVENT_CHAIN_SOLVING)
		e4:SetOperation(c810000095.disop)
		e4:SetLabelObject(tc)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e4,tp)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_CHAINING)
		e5:SetOperation(c810000095.disop)
		e5:SetLabelObject(tc)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e5,tp)
		Duel.SpecialSummonComplete()
	end
end
function c810000095.distg(e,c)
	return c:IsHasCardTarget(e:GetLabelObject())
end
function c810000095.disop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetHandler():GetControler(1-tp) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(e:GetLabelObject()) or not Duel.IsChainDisablable(ev) then return false end
	Duel.NegateEffect(ev)
end
