--Cross Xyz
function c511004413.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004413.target)
	e1:SetOperation(c511004413.operation)
	c:RegisterEffect(e1)
end
function c511004413.filter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsType(TYPE_XYZ) and Duel.IsExistingMatchingCard(c511004413.filter2,tp,LOCATION_MZONE,0,1,nil,e,tp,c)
end
function c511004413.filter2(c,e,tp,mc)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:GetLevel()==mc:GetRank() and Duel.IsExistingMatchingCard(c511004413.filter23,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,mc)
end
function c511004413.filter23(c,e,tp,m2c,m1c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_XYZ_LEVEL)
	e1:SetValue(m1c:GetRank())
	e1:SetCondition(function (e,c) return e:GetHandler():GetFlagEffect(511004411)~=0 end)
	e1:SetReset(RESET_EVENT+0x1fe0000+EVENT_CHAIN_SOLVED+EVENT_ADJUST)
	m1c:RegisterEffect(e1)
	m1c:RegisterFlagEffect(511004411,RESET_EVENT+0x1fe0000+EVENT_CHAIN_SOLVED+EVENT_ADJUST,0,1)
	local mg=Group.FromCards(m2c,m1c)
	local chk=c:IsXyzSummonable(mg,2,2)
	m1c:ResetFlagEffect(511004411)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and chk
end
function c511004413.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004413.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local tg1=Duel.SelectTarget(tp,c511004413.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tg2=Duel.SelectTarget(tp,c511004413.filter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp,tg1:GetFirst())
	tg1:GetFirst():RegisterFlagEffect(511004413,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	Group.Merge(tg1,tg2)
	Duel.SetTargetCard(tg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg1,tg1:GetCount(),0,0)
end
function c511004413.filter3(c)
	return c:GetFlagEffect(511004413)~=0
end
function c511004413.filter4(c)
	return c:GetFlagEffect(511004413)==0
end
function c511004413.filtersp(c,e,tp,mg)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and c:IsXyzSummonable(mg,2,2)
end
function c511004413.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg1=tg:Filter(c511004413.filter3,nil)
	local tg2=tg:Filter(c511004413.filter4,nil)
	local m1=tg1:GetFirst()
	local m2=tg2:GetFirst()
	-- treat rank as level
	if m1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(m1:GetRank())
		e1:SetReset(RESET_EVENT+0x1fe0000+EVENT_CHAIN_SOLVED+EVENT_ADJUST)
		m1:RegisterEffect(e1)
	end
	local mg=Group.CreateGroup()
	mg:AddCard(m1)
	mg:AddCard(m2)
	local ov=Group.CreateGroup()
	local s1=m1:GetOverlayGroup()
	local s2=m2:GetOverlayGroup()
	ov:Merge(s1)
	ov:Merge(s2)
	ov:Merge(mg)
	if m1 and m2 and Duel.IsExistingMatchingCard(c511004413.filtersp,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg) then
		--effect rank level
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_RANK_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		m1:RegisterEffect(e1)
		local g=Duel.SelectMatchingCard(tp,c511004413.filtersp,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,mg)
		Duel.SendtoGrave(ov,REASON_RULE)
		Duel.SpecialSummon(g,SUMMON_TYPE_XYZ,tp,tp,false,true,POS_FACEUP)
		g:GetFirst():SetMaterial(mg)
		Duel.Overlay(g:GetFirst(),mg)
		g:GetFirst():CompleteProcedure()
	end
end