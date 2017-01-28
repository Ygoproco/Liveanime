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
function c511001611.notchk(c,xyz)
	return not c:IsCanBeXyzMaterial(xyz)
end
function c511001611.numfilter(c,g,matg,e,tp,ct)
	local mg=g:Clone()
	local tg=matg:Clone()
	mg:RemoveCard(c)
	tg:AddCard(c)
	local ctc=ct+c.xyz_number
	return Duel.IsExistingMatchingCard(c511001611.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,tg,ctc) 
		or mg:IsExists(c511001611.numfilter,1,nil,mg,tg,e,tp,ctc)
end
function c511001611.spfilter(c,e,tp,mg,ct)
	if mg:GetCount()==0 or mg:IsExists(c511001611.notchk,1,nil,c) or mg:IsContains(c) then return false end
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
		and c.xyz_number and c.xyz_number==ct
end
function c511001611.filter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c.xyz_number
end
function c511001611.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511001611.filter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and	g:IsExists(c511001611.numfilter,1,nil,g,Group.CreateGroup(),e,tp,0) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c511001611.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001611.filter,tp,LOCATION_EXTRA,0,nil)
	local sg=Group.CreateGroup()
	local ct=0
	if not g:IsExists(c511001611.numfilter,1,nil,g,sg,e,tp,ct) then return end
	while not Duel.IsExistingMatchingCard(c511001611.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,sg,ct) 
		or (g:IsExists(c511001611.numfilter,1,nil,g,sg,e,tp,ct) and Duel.SelectYesNo(tp,513)) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local tg=g:FilterSelect(tp,c511001611.numfilter,1,1,nil,g,sg,e,tp,ct)
		sg:Merge(tg)
		g:Sub(tg)
		ct=ct+tg:GetFirst().xyz_number
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001611.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sg,ct)
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(sg)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		Duel.Overlay(tc,sg)
		tc:CompleteProcedure()
	end
end
