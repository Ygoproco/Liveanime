--D/D/D Synchro
function c511015107.initial_effect(c)
	--Synchro monster, 1 tuner + n or more monsters
	function aux.AddSynchroProcedure(c,f1,f2,ct)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=ct
		mt.maxntct=99
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,ct,99))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,ct,99))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,ct,99))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	--Synchro monster, 1 tuner + 1 monster
	function Auxiliary.AddSynchroProcedure2(c,f1,f2)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,1,1))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,1,1))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,1,1))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,51100759+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c511015107.target)
	e1:SetOperation(c511015107.activate)
	c:RegisterEffect(e1)
end
function c511015107.ArmFilter(c,lv,syncard,onField)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	
	local g = Duel.GetMatchingGroup(c511015107.matfilter2,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil,syncard)
	g:RemoveCard(c)
	
	local lv2 = lv-c:GetSynchroLevel(syncard)
	
	local b = true
	if onField then b = c:IsOnField() end
	return b and c:IsCode(47198668) and mt.nontuner_filter and mt.nontuner_filter(c)
		and (lv2==0 or g:CheckWithSumEqual(Card.GetSynchroLevel,lv2,mt.minntct-1,mt.maxntct-1,syncard))
end
function c511015107.fieldFilter(c,lv,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	
	local g = Duel.GetMatchingGroup(c511015107.matfilter2,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil,syncard)
	g:RemoveCard(c)
	
	local lv2 = lv-c:GetSynchroLevel(syncard)
	
	return c:IsOnField() and mt.nontuner_filter and mt.nontuner_filter(c)
		and (lv2==0 or g:CheckWithSumEqual(Card.GetSynchroLevel,lv2,mt.minntct-1,mt.maxntct-1,syncard))
end
function c511015107.filter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,true,false) and c:IsSetCard(0x10af)
		and Duel.IsExistingMatchingCard(c511015107.matfilter1,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil,c,e)
end
function c511015107.matfilter1(c,syncard,e)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	
	local tp = e:GetHandler():GetControler()
	
	local zone = LOCATION_ONFIELD+LOCATION_HAND
	
	local fieldFull = Duel.GetLocationCount(tp,LOCATION_MZONE)==0 and not c:IsLocation(LOCATION_MZONE)
	
	local g = Duel.GetMatchingGroup(c511015107.matfilter2,tp,zone,0,nil,syncard) 
	local lv = syncard:GetLevel()-c:GetSynchroLevel(syncard)
	if e:GetHandler()==c then
		lv=lv-2

		return g:IsExists(c511015107.ArmFilter,1,nil,lv,syncard,fieldFull)
			and mt.tuner_filter and mt.tuner_filter(c)
	else	
		if fieldFull then
			return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) 
				and c:IsType(TYPE_TUNER) and mt.tuner_filter and mt.tuner_filter(c)
				and g:IsExists(c511015107.fieldFilter,1,nil,lv,syncard)
		else	
			return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) 
				and c:IsType(TYPE_TUNER) and mt.tuner_filter and mt.tuner_filter(c)
				and g:CheckWithSumEqual(Card.GetSynchroLevel,lv,mt.minntct,mt.maxntct,syncard)
		end
	end
end
function c511015107.matfilter2(c,syncard)
	local code=syncard:GetOriginalCode()
	local mt=_G["c" .. code]
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsType(TYPE_MONSTER)
		and not c:IsType(TYPE_TUNER) and mt.nontuner_filter and mt.nontuner_filter(c)
end
function c511015107.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511015107.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015107.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=-1 then return end
	local g=Duel.GetMatchingGroup(c511015107.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local matTun=Duel.SelectMatchingCard(tp,c511015107.matfilter1,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil,tc,e):GetFirst()
		
		local code=tc:GetOriginalCode()
		local mt=_G["c" .. code]
		local gMat = Duel.GetMatchingGroup(c511015107.matfilter2,tp,LOCATION_ONFIELD+LOCATION_HAND,0,nil,tc) 
		
		local fieldFull = Duel.GetLocationCount(tp,LOCATION_MZONE)==0 and not matTun:IsLocation(LOCATION_MZONE)
		
		local lv = -1
		local matArm = nil
		if matTun == e:GetHandler() then
			lv = tc:GetLevel()-2
			
			matArm=gMat:FilterSelect(tp,c511015107.ArmFilter,1,1,nil,lv,tc,fieldFull):GetFirst()
			gMat:RemoveCard(matArm)
			lv = lv-matArm:GetSynchroLevel(tc)
		else
			lv = tc:GetLevel()-matTun:GetSynchroLevel(tc)
			
			if fieldFull then
				matArm=gMat:FilterSelect(tp,c511015107.fieldFilter,1,1,nil,lv,tc):GetFirst()
				gMat:RemoveCard(matArm)
				lv = lv-matArm:GetSynchroLevel(tc)
			end
		end
		
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
		local mat=gMat:SelectWithSumEqual(tp,Card.GetSynchroLevel,lv,mt.minntct,mt.maxntct,tc)
		mat:AddCard(matTun)	
		if matArm then		
			mat:AddCard(matArm)
		end
		tc:SetMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
