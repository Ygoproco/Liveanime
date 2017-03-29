--Odd-Eyes Synchro Gate
function c511015105.initial_effect(c)
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
	e1:SetCost(c511015105.cost)
	e1:SetTarget(c511015105.target)
	e1:SetOperation(c511015105.activate)
	c:RegisterEffect(e1)	
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
end

function c511015105.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c511015105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c511015105.splimit)
	Duel.RegisterEffect(e1,tp)
end

function c511015105.filter1(c,e,tp)
	return c:IsCode(16178681) and c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511015105.filter2(c,e,tp,odd)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsType(TYPE_TUNER)
		and Duel.IsExistingMatchingCard(c511015105.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,odd)
end
function c511015105.filter3(c,e,tp,syn,odd)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	odd:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	e2:SetValue(TYPE_TUNER)
	odd:RegisterEffect(e2)

	local result = c511015105.filter4(c,e,tp,syn,odd)
		
	e1:Reset()
	e2:Reset()
	
	return result
end
function c511015105.filter4(c,e,tp,syn,odd)
	local code=c:GetOriginalCode()
	local mt=_G["c" .. code]
	
	return c:IsType(TYPE_SYNCHRO) --and c:IsType(TYPE_PENDULUM)
		and c:GetLevel()==syn:GetSynchroLevel(c)+odd:GetSynchroLevel(c) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
		and mt.sync and mt.minntct and mt.minntct==1 
		and mt.tuner_filter and mt.tuner_filter(odd) 
		and mt.nontuner_filter and mt.nontuner_filter(syn)
end
function c511015105.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local tc1 = Duel.GetFirstMatchingCard(c511015105.filter1,tp,LOCATION_EXTRA,0,nil,e,tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and tc1
			and Duel.IsExistingMatchingCard(c511015105.filter2,tp,LOCATION_GRAVE,0,1,nil,e,tp,tc1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local c1=Duel.SelectTarget(tp,c511015105.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
	local c2=Duel.SelectTarget(tp,c511015105.filter2,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c1):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,Group:FromCards(c1,c2),2,0,0)
end
function c511015105.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	
	if sg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
	local n = Duel.SpecialSummonComplete()
	Duel.BreakEffect()
	if n==2 then
		tc = sg:GetFirst()
		
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e2)
		
		tc = Duel.SelectMatchingCard(tp,c511015105.filter4,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,sg:GetNext(),tc):GetFirst()
		tc:SetMaterial(sg)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_MATERIAL+REASON_SYNCHRO)
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		
		--destroy
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetCondition(c511015105.descon)
		e1:SetCost(c511015105.descost)
		e1:SetOperation(c511015105.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e:GetHandler():RegisterEffect(e1)
		e1:SetLabelObject(tc)
	end
end
function c511015105.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc and eg:IsContains(tc) 
end
function c511015105.thfilter(c)
	return c:IsAbleToHand() and c:IsCode(511015106)
end
function c511015105.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:GetLabelObject():IsReason(REASON_DESTROY) and Duel.IsExistingMatchingCard(c511015105.thfilter,tp,LOCATION_DECK,0,1,nil)
		and e:GetHandler():IsAbleToGrave() and Duel.SelectYesNo(tp,aux.Stringid(511015105,0)) then
		Duel.SendtoGrave(e:GetHandler(),REASON_COST)
		e:GetHandler():RegisterFlagEffect(511015105,RESET_EVENT+EVENT_CHAIN_END+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511015105.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511015105)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c511015105.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	end
end