--D/D/D Fusion
--fixed by MLD
function c511015101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015101.target)
	e1:SetOperation(c511015101.activate)
	c:RegisterEffect(e1)
	if not c511015101.global_check then
		c511015101.global_check=true
		c511015101[0]=Group.CreateGroup()
		c511015101[0]:KeepAlive()
		c511015101[1]=Group.CreateGroup()
		c511015101[1]:KeepAlive()
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511015101.setop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511015101.setop(e,tp,eg,ep,ev,re,r,rp)
	if c511015101[0]:GetCount()>0 then return end
	for j=0,1 do
		for i=1,5 do
			local tc=Duel.CreateToken(j,419)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(511002961)
			tc:RegisterEffect(e1)
			c511015101[0]:AddCard(tc)
		end
	end
	for j=0,1 do
		for i=1,2 do
			local tc=Duel.CreateToken(j,47198668)
			c511015101[1]:AddCard(tc)
		end
	end
end
function c511015101.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c511015101.filter2(c,e,tp,m,f,chkf)
	if not c:IsType(TYPE_FUSION) or not c:IsSetCard(0x10af) or (f and not f(c))
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) then return false end
	if c:CheckFusionMaterial(m,nil,chkf) then return true end
	local mc=e:GetHandler()
	if mc:IsCanBeFusionMaterial(c) and m:IsExists(Card.IsCode,1,nil,47198668) and c511015101[1]:IsExists(c511015101.cfilter,1,nil,c,chkf) then
		m:AddCard(mc)
		local e1=Effect.CreateEffect(mc)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511002961)
		e1:SetReset(RESET_CHAIN)
		mc:RegisterEffect(e1)
		local res=m:IsExists(c511015101.fusfilter2,1,nil,c,m,chkf)
		e1:Reset()
		m:RemoveCard(mc)
		return res
	end
	return false
end
function c511015101.fusfilter2(c,fc,m,chkf)
	if not c:IsCode(47198668) then return false end
	return fc:CheckFusionMaterial(m,c,chkf)
end
function c511015101.cfilter(c,fc)
	c511015101[0]:AddCard(c)
	local res=fc:CheckFusionMaterial(c511015101[0],c)
	c511015101[0]:RemoveCard(c)
	return res
end
function c511015101.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local mg1=Duel.GetFusionMaterial(tp)
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local res=Duel.IsExistingMatchingCard(c511015101.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511015101.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,tp)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015101.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c511015101.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c511015101.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511015101.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,tp)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1
			if not tc:CheckFusionMaterial(mg1,nil,chkf) or (c:IsCanBeFusionMaterial(tc) and mg1:IsExists(Card.IsCode,1,nil,47198668) 
				and c511015101[1]:IsExists(c511015101.cfilter,1,nil,tc,chkf) and Duel.SelectYesNo(tp,65)) then
				mg1:AddCard(c)
				local e1=Effect.CreateEffect(c)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(511002961)
				e1:SetReset(RESET_CHAIN)
				c:RegisterEffect(e1)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local matc=mg1:FilterSelect(tp,c511015101.fusfilter2,1,1,nil,tc,mg1,chkf):GetFirst()
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,matc,chkf)
			else
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			end
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2
			if not tc:CheckFusionMaterial(mg2,nil,chkf) or (c:IsCanBeFusionMaterial(tc) and mg2:IsExists(Card.IsCode,1,nil,47198668) 
				and c511015101[1]:IsExists(c511015101.cfilter,1,nil,tc,chkf) and Duel.SelectYesNo(tp,65)) then
				mg2:AddCard(c)
				local e1=Effect.CreateEffect(c)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(511002961)
				e1:SetReset(RESET_CHAIN)
				c:RegisterEffect(e1)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
				local matc=mg2:FilterSelect(tp,c511015101.fusfilter2,1,1,nil,tc,mg2,chkf):GetFirst()
				mat2=Duel.SelectFusionMaterial(tp,tc,mg2,matc,chkf)
			else
				mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			end
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
