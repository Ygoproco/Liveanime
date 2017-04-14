--超越融合
function c511016005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76647978,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511016005.cost)
	e1:SetTarget(c511016005.target)
	e1:SetOperation(c511016005.activate)
	c:RegisterEffect(e1)
end
function c511016005.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511016005.mfilter(c)
	return c:IsOnField() and not c:IsHasEffect(EFFECT_CANNOT_SPECIAL_SUMMON)
end
function c511016005.filter1(c,e1,e2,e,tp,mg)
	return (not e1 or c:IsCanBeEffectTarget(e1)) and (not e2 or (c:IsRelateToEffect(e2) and not c:IsImmuneToEffect(e2))) 
		and mg:IsExists(c511016005.filter2,1,c,e1,e2,e,tp,c)
end
function c511016005.filter2(c,e1,e2,e,tp,mc)
	local mg=Group.FromCards(c,mc)
	return (not e1 or c:IsCanBeEffectTarget(e1)) and (not e2 or (c:IsRelateToEffect(e2) and not c:IsImmuneToEffect(e2))) 
		and Duel.IsExistingMatchingCard(c511016005.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg)
end
function c511016005.spfilter(c,e,tp,mg)
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(mg,nil)
end
function c511016005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetFusionMaterial(tp):Filter(c511016005.mfilter,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonCount(tp,2) and mg:IsExists(c511016005.filter1,1,nil,e,nil,e,tp,mg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(tp,c511016005.filter1,1,1,nil,e,nil,e,tp,mg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(tp,c511016005.filter2,1,1,g1:GetFirst(),e,nil,e,tp,g1:GetFirst())
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,g1:GetCount(),0,0)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimit(aux.FALSE)
	end
end
function c511016005.mspfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA)
end
function c511016005.lvfilter(c)
	return c:GetLevel()~=4
end
function c511016005.tunerfilter(c)
	return not c:IsType(TYPE_TUNER)
end
function c511016005.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(c511016005.filter1,nil,nil,e,e,tp,tg)
	if g:GetCount()<2 or g:IsExists(Card.IsControler,1,nil,1-tp) or g:IsExists(Card.IsImmuneToEffect,1,nil,e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511016005.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,g)
	local tc=sg:GetFirst()
	tc:SetMaterial(g)
	Duel.SendtoGrave(g,REASON_MATERIAL+REASON_FUSION+REASON_EFFECT)
	Duel.BreakEffect()
	if Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP) then
		tc:CompleteProcedure()
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		local spg=g:Filter(aux.NecroValleyFilter(c511016005.mspfilter),nil,e,tp)
		if spg:GetCount()>1 then
			Duel.BreakEffect()
			local fid=e:GetHandler():GetFieldID()
			local spgc=spg:GetFirst()
			while spgc do
				Duel.SpecialSummonStep(spgc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_SET_ATTACK_FINAL)
				e1:SetValue(0)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				spgc:RegisterEffect(e1,true)
				spgc:RegisterFlagEffect(51116005,RESET_PHASE+PHASE_END,0,1,fid)
				spgc=spg:GetNext()
			end
			Duel.SpecialSummonComplete()
			local con1=spg:IsExists(c511016005.lvfilter,1,nil)
			local con2=spg:IsExists(c511016005.tunerfilter,1,nil)
			local op=2
			if (con1 or con2) and Duel.SelectYesNo(tp,65) then
				if con1 and con2 then
					op=Duel.SelectOption(tp,aux.Stringid(1006081,0),aux.Stringid(82744076,0))
				elseif con1 then
					Duel.SelectOption(tp,aux.Stringid(1006081,0))
					op=0
				elseif con2 then
					Duel.SelectOption(tp,aux.Stringid(82744076,0))
					op=1
				end
				if op==0 then
					local gc=spg:GetFirst()
					while gc do
						local e2=Effect.CreateEffect(e:GetHandler())
						e2:SetType(EFFECT_TYPE_SINGLE)
						e2:SetCode(EFFECT_CHANGE_LEVEL)
						e2:SetValue(4)
						e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
						gc:RegisterEffect(e2)
						gc=spg:GetNext()
					end
				elseif op==1 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
					local tug=spg:FilterSelect(tp,c511016005.tunerfilter,1,1,nil)
					Duel.HintSelection(tug)
					local e2=Effect.CreateEffect(e:GetHandler())
					e2:SetType(EFFECT_TYPE_SINGLE)
					e2:SetCode(EFFECT_ADD_TYPE)
					e2:SetValue(TYPE_TUNER)
					e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
					tug:GetFirst():RegisterEffect(e2)
				end
				if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
				spg:KeepAlive()
				local e3=Effect.CreateEffect(e:GetHandler())
				e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
				e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
				e3:SetCode(EVENT_PHASE+PHASE_END)
				e3:SetLabel(fid)
				e3:SetLabelObject(spg)
				e3:SetCountLimit(1)
				e3:SetCondition(c511016005.descon)
				e3:SetTarget(c511016005.destg)
				e3:SetOperation(c511016005.desop)
				e3:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e3,tp)
			end
		end
	end
end
function c511016005.chkfilter(c,fid)
	return c:GetFlagEffectLabel(51116005)==fid and c:IsReason(REASON_MATERIAL) and c:IsReason(REASON_SYNCHRO+REASON_XYZ)
end
function c511016005.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	return not g:IsExists(c511016005.chkfilter,2,nil,e:GetLabel())
end
function c511016005.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,0)
end
function c511016005.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		Duel.BreakEffect()
		local dam=dg:GetSum(Card.GetPreviousAttackOnField)
		Duel.Damage(tp,dam,REASON_EFFECT)
	end
end
