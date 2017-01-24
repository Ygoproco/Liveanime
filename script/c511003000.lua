--Pendulum Xyz
function c511003000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511003000.target)
	e1:SetOperation(c511003000.activate)
	c:RegisterEffect(e1)
end
function c511003000.spfilter(c,mg,lv,rk)
	local tc=mg:GetFirst()
	while tc do
		tc:AssumeProperty(ASSUME_LEVEL,lv)
		tc:AssumeProperty(ASSUME_RANK,rk)
		tc:AssumeProperty(ASSUME_TYPE,tc:GetOriginalType())
		tc=mg:GetNext()
	end
	return c:IsXyzSummonable(mg,2,2)
end
function c511003000.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local pc1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
		local pc2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
		if not pc1 or not pc2 then return false end
		local lv1=pc1:GetLevel()
		local lv2=pc2:GetLevel()
		local rk1=pc1:GetRank()
		local rk2=pc2:GetRank()
		local g=Group.FromCards(pc1,pc2)
		return Duel.IsExistingMatchingCard(c511003000.spfilter,tp,LOCATION_EXTRA,0,1,nil,g,lv1,rk1) 
			or Duel.IsExistingMatchingCard(c511003000.spfilter,tp,LOCATION_EXTRA,0,1,nil,g,lv2,rk2)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511003000.activate(e,tp,eg,ep,ev,re,r,rp)
	local pc1=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local pc2=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not pc1 or not pc2 then return end
	local lv1=pc1:GetLevel()
	local lv2=pc2:GetLevel()
	local rk1=pc1:GetRank()
	local rk2=pc2:GetRank()
	local mg=Group.FromCards(pc1,pc2)
	local g1=Duel.GetMatchingGroup(c511003000.spfilter,tp,LOCATION_EXTRA,0,nil,mg,lv1,rk1)
	local g2=Duel.GetMatchingGroup(c511003000.spfilter,tp,LOCATION_EXTRA,0,nil,mg,lv2,rk2)
	g1:Merge(g2)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=g1:Select(tp,1,1,nil):GetFirst()
		if not c511003000.spfilter(xyz,mg,lv1,rk1) then c511003000.spfilter(xyz,mg,lv2,rk2) end
		Duel.XyzSummon(tp,xyz,mg)
	end
end
