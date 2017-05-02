--幽合
function c100002002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100002002.target)
	e1:SetOperation(c100002002.activate)
	c:RegisterEffect(e1)
end
function c100002002.filter1(c,e)
	return c:IsOnField() and c:IsCanBeFusionMaterial() and c:IsRace(RACE_ZOMBIE) and (not e or not c:IsImmuneToEffect(e))
end
function c100002002.filter2(c,e)
	return c:IsCanBeFusionMaterial() and c:IsRace(RACE_ZOMBIE) and (not e or not c:IsImmuneToEffect(e))
end
function c100002002.filter3(c,e,tp,m,f,chkf,chainm)
	return c:IsType(TYPE_FUSION) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and m:IsExists(c100002002.matfilter1,1,nil,m,c,chkf,chainm)
end
function c100002002.matfilter1(c,m,fc,chkf,chainm)
	return (c:IsOnField() or chainm) and m:IsExists(c100002002.matfilter2,1,c,fc,chkf,c,chainm)
end
function c100002002.matfilter2(c,fc,chkf,mc,chainm)
	local g=Group.FromCards(c,mc)
	return (c:IsLocation(LOCATION_DECK+LOCATION_GRAVE) or chainm) and fc:CheckFusionMaterial(g,nil,chkf)
end
function c100002002.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetFusionMaterial(tp):Filter(c100002002.filter1,nil)
		local mg2=Duel.GetMatchingGroup(c100002002.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,nil)
		mg1:Merge(mg2)
		local res=Duel.IsExistingMatchingCard(c100002002.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf,false)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp):Filter(c100002002.filter2,nil)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c100002002.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf,true)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100002002.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c100002002.filter1,nil,e)
	local mg=Duel.GetMatchingGroup(c100002002.filter2,tp,LOCATION_GRAVE+LOCATION_DECK,0,nil,e)
	mg1:Merge(mg)
	local sg1=Duel.GetMatchingGroup(c100002002.filter3,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf,false)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp):Filter(c100002002.filter2,nil,e)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c100002002.filter3,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf,true)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat1=mg1:FilterSelect(tp,c100002002.matfilter1,1,1,nil,mg1,tc,chkf,false)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat2=mg1:FilterSelect(tp,c100002002.matfilter2,1,1,mat1:GetFirst(),tc,chkf,mat1:GetFirst(),false)
			mat1:Merge(mat2)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat1=mg2:FilterSelect(tp,c100002002.matfilter1,1,1,nil,mg2,tc,chkf,true)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
			local mat2=mg2:FilterSelect(tp,c100002002.matfilter2,1,1,mat1:GetFirst(),tc,chkf,mat1:GetFirst(),true)
			mat1:Merge(mat2)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat1)
		end
		tc:CompleteProcedure()
	end
end
