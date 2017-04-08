--D/D/D Fusion
function c511015101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015101.target)
	e1:SetOperation(c511015101.activate)
	c:RegisterEffect(e1)
end

function c511015101.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511015101.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x10af) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end
function c511015101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetFusionMaterial(tp)
		
		if mg1:IsExists(c511015101.Armfilter,1,nil,e) then
			mg1:AddCard(e:GetHandler())
		end
		
		local res1=Duel.IsExistingMatchingCard(c511015101.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)

		if not res1 then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res1 = Duel.IsExistingMatchingCard(c511015101.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res1
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015101.Armfilter(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e) and c:GetOriginalCode()==47198668
end
function c511015101.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c511015101.filter1,nil,e)
	if mg1:IsExists(c511015101.Armfilter,1,nil,e) then
		mg1:AddCard(e:GetHandler())
	end
	local sg1=Duel.GetMatchingGroup(c511015101.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511015101.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=sg:Select(tp,1,1,nil):GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1 = nil
			if mg1:IsContains(e:GetHandler()) and Duel.SelectYesNo(tp,aux.Stringid(511015101,0)) then
				local mat2 = mg1:FilterSelect(tp,c511015101.Armfilter,1,1,nil,e):GetFirst()
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,mat2,chkf)
			else
				mg1:RemoveCard(e:GetHandler())
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			end

			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
