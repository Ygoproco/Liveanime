--Giant's Training
function c511001413.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001413.cost)
	e1:SetTarget(c511001413.target)
	e1:SetOperation(c511001413.activate)
	c:RegisterEffect(e1)
end
function c511001413.cfilter(c,tid)
	return c:IsFaceup() and c:IsCode(511001412) and c:GetTurnID()>tid
end
function c511001413.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511001413.cfilter,1,nil,tid) end
	local g=Duel.SelectReleaseGroup(tp,c511001413.cfilter,1,1,nil,tid)
	Duel.Release(g,REASON_COST)
end
function c511001413.filter(c,e,tp)
	return c:IsCode(511001414) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c511001413.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001413.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511001413.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c511001413.filter),tp,0x13,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)>0 then
		tc:CompleteProcedure()
	end
end
