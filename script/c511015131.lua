--Doll House
function c511015131.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511015131.con)
	e2:SetOperation(c511015131.op)
	c:RegisterEffect(e2)
	
	if not c511015131.global_check then
		c511015131.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROY)
		ge1:SetOperation(c511015131.gchk)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511015131.gclear)
		Duel.RegisterEffect(ge2,0)
	end
end
c511015131.g=Group.CreateGroup()
function c511015131.gchk(e,tp,eg,ev,ep,re,r,rp)
	local c=eg:GetFirst()
	while c do
		if c:GetPreviousControler()==tp and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x120B) then
			c511015131.g:AddCard(c) 
		end
		c=eg:GetNext()
	end
end
function c511015131.gclear(e,tp,eg,ev,ep,re,r,rp)
	if c511015131.g then
		c511015131.g:Clear()
	end
end

function c511015131.sfilter(c,e,tp,g)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x120B) and 
		g:IsExists(function (c,lv) return c:GetLevel()==lv end,1,nil,c:GetLevel()-2) and
		c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,false,false)
end
function c511015131.con(e,tp,eg,ep,ev,re,r,rp)
	local n=c511015131.g:GetCount()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and ft>0 then ft=2 end
	return n>1 and n<=ft and Duel.IsExistingMatchingCard(c511015131.sfilter,tp,LOCATION_DECK,0,n-1,nil,e,tp,c511015131.g)
end
function c511015131.op(e,tp,eg,ep,ev,re,r,rp)
	local n=c511015131.g:GetCount()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and ft>0 then ft=2 end
	if n>ft then n=ft end
	local tg=Duel.SelectMatchingCard(tp,c511015131.sfilter,tp,LOCATION_DECK,0,n-1,n-1,nil,e,tp,c511015131.g)
	Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
end