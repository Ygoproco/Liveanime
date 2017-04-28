--Synchro Panic
function c511004428.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROY)
	e1:SetCondition(c511004428.conditionat)
	e1:SetTarget(c511004428.targetat)
	e1:SetOperation(c511004428.operationat)
	c:RegisterEffect(e1)
end
function c511004428.conditionat(e,tp,eg,ev,ep,re,r,rp)
	local egf=eg:Filter(Card.IsType,nil,TYPE_SYNCHRO)
	local egc=eg:FilterCount(Card.IsType,nil,TYPE_SYNCHRO)
	if egc==1 then e:SetLabelObject(egf:GetFirst()) end
	return egc==1
end
function c511004428.filter(c,e,tp,sc)
	local scm=sc:GetMaterial()
	return scm:GetCount()>0 and scm:IsContains(c) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false,POS_FACEUP_ATTACK,tp)
end
function c511004428.targetat(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004428.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,e:GetLabelObject()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local tg=Duel.SelectMatchingCard(tp,c511004428.filter,tp,LOCATION_GRAVE,0,1,ft,nil,e,tp,e:GetLabelObject())
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tg,tg:GetCount(),0,0)
end
function c511004428.operationat(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft>0 and tg:GetCount()>ft then tg=tg:Select(tp,1,ft,nil) end
	if ft>0 and tg:GetCount()>0 then
		Duel.SpecialSummon(tg,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP_ATTACK)
		local tc=tg:GetFirst()
		while tc do
			 local e1=Effect.CreateEffect(c)
			 e1:SetType(EFFECT_TYPE_SINGLE)
			 e1:SetCode(EFFECT_INDESTRUCTABLE)
			 e1:SetValue(1)
			 e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			 tc:RegisterEffect(e1)
			 tc=tg:GetNext()
		end
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetTarget(c511004428.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END,3)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511004428.desop)
	e2:SetCountLimit(1)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,3)
	c:RegisterEffect(e2)
end
function c511004428.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c511004428.desop(e,tp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		Duel.Destroy(c,REASON_RULE)
	end
end
