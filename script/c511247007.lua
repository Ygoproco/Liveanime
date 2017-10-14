--Purge Ray (Anime)
function c511247007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511247007.cost)
	e1:SetTarget(c511247007.target)
	e1:SetOperation(c511247007.activate)
	c:RegisterEffect(e1)
end
function c511247007.cfilter(c,e,tp)
	local rk=c:GetRank()
	return rk>1 and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c511247007.filter,tp,LOCATION_EXTRA,0,1,nil,rk,e,tp)
end
function c511247007.filter(c,rk,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsRankBelow(rk-1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511247007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511247007.cfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511247007.cfilter,1,1,nil,e,tp)
	e:SetLabel(g:GetFirst():GetRank())
	Duel.Release(g,REASON_COST)
end
function c511247007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	end
end
function c511247007.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511247007.spop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetLabel(e:GetLabel())
	Duel.RegisterEffect(e1,tp)
end
function c511247007.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511247007)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local rk=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511247007.filter,tp,LOCATION_EXTRA,0,1,1,nil,rk,e,tp)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end

