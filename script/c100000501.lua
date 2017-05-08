--幻影融合
function c100000501.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000501.target)
	e1:SetOperation(c100000501.activate)
	c:RegisterEffect(e1)
end
function c100000501.filter0(c,e,tp,mg)
	return mg:IsExists(c100000501.filter1,1,c,e,tp,c)
end
function c100000501.filter1(c,e,tp,mc)
	local mg=Group.FromCards(c,mc)
	return Duel.IsExistingMatchingCard(c100000501.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg)
end
function c100000501.filter2(c,e,tp,mg)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(mg,nil)
end
function c100000501.mfilter(c,e)
	return c:IsCanBeFusionMaterial() and (c:IsSetCard(0x5008) or c:IsCode(27780618)) and (not e or not c:IsImmuneToEffect(e))
end
function c100000501.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(c100000501.mfilter,tp,LOCATION_SZONE,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:IsExists(c100000501.filter0,1,nil,e,tp,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000501.filter3(c,e,tp,mg)
	return not c:IsImmuneToEffect(e) and mg:IsExists(c100000501.filter4,1,c,e,tp,c)
end
function c100000501.filter4(c,e,tp,mc)
	local mg=Group.FromCards(c,mc)
	return not c:IsImmuneToEffect(e) and Duel.IsExistingMatchingCard(c100000501.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg)
end
function c100000501.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 then return end
	local mg=Duel.GetMatchingGroup(c100000501.mfilter,tp,LOCATION_SZONE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(tp,c100000501.filter3,1,1,nil,e,tp,mg)
	if g1:GetCount()==0 then return end
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(tp,c100000501.filter4,1,1,tc1,e,tp,tc1)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c100000501.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g1)
	local tc=sg:GetFirst()
	tc:SetMaterial(g1)
	Duel.SendtoGrave(g1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.BreakEffect()
	Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
	tc:CompleteProcedure()
end
