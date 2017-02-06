--Numbers Evaille
function c511001611.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001611.target)
	e1:SetOperation(c511001611.activate)
	c:RegisterEffect(e1)
end
function c511001611.spfilterchk(c,e,tp,mg)
	if not c:IsSetCard(0x48) or not c:IsType(TYPE_XYZ) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		or not c.xyz_number then return false end
		
	if c.xyz_number>0 then
		return mg:CheckWithSumEqual(function(c) return c.xyz_number end,c.xyz_number,1,99)
	else
		return mg:IsExists(function(c) return c.xyz_number==0 end,1,nil)
	end
end
function c511001611.filter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c.xyz_number
end
function c511001611.spfilter(c,e,tp,g,ct)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c.xyz_number==ct and not g:IsContains(c)
end
function c511001611.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(c511001611.filter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and	Duel.IsExistingMatchingCard(c511001611.spfilterchk,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c511001611.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(c511001611.filter,tp,LOCATION_EXTRA,0,nil)
	if not Duel.IsExistingMatchingCard(c511001611.spfilterchk,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg=mg:Select(tp,1,99,nil)
	while not Duel.IsExistingMatchingCard(c511001611.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,sg,sg:GetSum(function(c) return c.xyz_number end)) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		sg=mg:Select(tp,1,99,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001611.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sg,sg:GetSum(function(c) return c.xyz_number end))
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(sg)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		Duel.Overlay(tc,sg)
		tc:CompleteProcedure()
	end
end
