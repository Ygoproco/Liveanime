--Underworld Circle
--fixed by Larry126
function c513000118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000118.target)
	e1:SetOperation(c513000118.activate)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(102380,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(2)
	e2:SetCondition(c513000118.spcon)
	e2:SetTarget(c513000118.sptg)
	e2:SetOperation(c513000118.spop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(513000118)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,1)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--ignoring summoning condition
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4010,6))
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0xff,0xff)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetTarget(function(e,c)return c:GetFlagEffect(5130001181)>0 and c:GetOriginalLevel()>7 end)
	e4:SetCondition(c513000118.ttcon2)
	e4:SetOperation(c513000118.ttop2)
	e4:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetDescription(aux.Stringid(4010,7))
	e5:SetTarget(function(e,c)return c:GetFlagEffect(5130001182)>0 and c:GetOriginalLevel()>7 end)
	e5:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetTarget(function(e,c)return c:GetFlagEffect(5130001181)>0 and c:GetOriginalLevel()>4 and c:GetOriginalLevel()<8 end)
	e6:SetCondition(c513000118.ttcon1)
	e6:SetOperation(c513000118.ttop1)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetDescription(aux.Stringid(4010,7))
	e7:SetTarget(function(e,c)return c:GetFlagEffect(5130001182)>0 and c:GetOriginalLevel()>4 and c:GetOriginalLevel()<8 end)
	e7:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e7)
	if not c513000118.global_check then
		c513000118.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c513000118.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
	end
	local f=Card.IsCanBeSpecialSummoned
	Card.IsCanBeSpecialSummoned=function(c,e,tpe,tp,con,conr)
		if Duel.IsPlayerAffectedByEffect(tp,513000118) then return c:IsType(TYPE_MONSTER) and f(c,e,tpe,tp,true,conr) end
		return f(c,e,tpe,tp,con,conr)
	end
	local proc=Duel.SpecialSummonStep
	Duel.SpecialSummonStep=function(tc,tpe,sump,tp,check,limit,pos)
		if Duel.IsPlayerAffectedByEffect(sump,513000118) then proc(tc,tpe,sump,tp,true,limit,pos) else proc(tc,tpe,sump,tp,check,limit,pos) end
	end
	local proc2=Duel.SpecialSummon
	Duel.SpecialSummon=function(g,tpe,sump,tp,check,limit,pos)
		if Duel.IsPlayerAffectedByEffect(sump,513000118) then proc2(g,tpe,sump,tp,true,limit,pos) else proc2(g,tpe,sump,tp,check,limit,pos) end
	end
	local uc=c
	local revive=Card.EnableReviveLimit
	Card.EnableReviveLimit=function(c)
		if Duel.IsPlayerAffectedByEffect(sump,513000118) then revive(uc) else revive(c) end
	end
end
function c513000118.ttcon1(e,c,minc)
	if c==nil then return true end
	return minc<=1 and Duel.CheckTribute(c,1)
end
function c513000118.ttop1(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c513000118.ttcon2(e,c,minc)
	if c==nil then return true end
	return minc<=2 and Duel.CheckTribute(c,2)
end
function c513000118.ttop2(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,2,2)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c513000118.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c513000118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.GetMatchingGroup(c513000118.filter,tp,LOCATION_DECK,LOCATION_DECK,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,tg:GetCount(),0,0)
end
function c513000118.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=Duel.GetMatchingGroup(c513000118.filter,tp,LOCATION_DECK,LOCATION_DECK,nil)
	local tg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
	if sg:GetCount()>0 then
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
	local g1=Duel.GetMatchingGroup(Card.IsHasEffect,tp,0xff,0xff,nil,EFFECT_REVIVE_LIMIT)
	local tc1=g1:GetFirst()
	if tc1 then
		while tc1 do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_REVIVE_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			tc1:RegisterEffect(e1)
			tc1=g1:GetNext()
		end
	end
	local g2=Duel.GetMatchingGroup(Card.IsHasEffect,tp,0xff,0xff,nil,EFFECT_LIMIT_SUMMON_PROC)
	local tc2=g2:GetFirst()
	if tc2 then
		while tc2 do
			tc2:RegisterFlagEffect(5130001181,0,0,1)
			tc2=g2:GetNext()
		end
	end
	local g3=Duel.GetMatchingGroup(Card.IsHasEffect,tp,0xff,0xff,nil,EFFECT_LIMIT_SET_PROC)
	local tc3=g3:GetFirst()
	if tc3 then
		while tc3 do
			tc3:RegisterFlagEffect(5130001182,0,0,1)
			tc3=g3:GetNext()
		end
	end
end
function c513000118.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,5130001180)==0 and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c513000118.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000118.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000118.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.RegisterFlagEffect(tp,5130001180,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_GRAVE)
end
function c513000118.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c513000118.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g1=Duel.SelectMatchingCard(tp,c513000118.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c513000118.spfilter,1-tp,LOCATION_GRAVE,0,1,nil,e,1-tp)
		and Duel.SelectYesNo(1-tp,aux.Stringid(102380,0))
		and Duel.GetFlagEffect(1-tp,5130001180)==0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(1-tp,c513000118.spfilter,1-tp,LOCATION_GRAVE,0,1,1,nil,e,1-tp)
		Duel.SpecialSummonStep(g2:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
		Duel.RegisterFlagEffect(1-tp,5130001180,RESET_PHASE+PHASE_END,0,1)
	end
	Duel.SpecialSummonComplete()
end
function c513000118.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsFaceup,nil)
	local tc=g:GetFirst()
	while tc do
		if Duel.IsPlayerAffectedByEffect(tc:GetSummonPlayer(),513000118) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x47e0000)
			e1:SetCondition(c513000118.recon)
			e1:SetValue(LOCATION_REMOVED)
			tc:RegisterEffect(e1,true)
		end
		tc=g:GetNext()
	end
end
function c513000118.recon(e)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and Duel.IsPlayerAffectedByEffect(c:GetSummonPlayer(),513000118)
end
