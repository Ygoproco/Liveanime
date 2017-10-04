--Obligatory Summon
function c511000210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000210.target)
	e1:SetOperation(c511000210.activate)
	c:RegisterEffect(e1)
end
function c511000210.cfilter(c,race)
	return c:IsFaceup() and c:IsRace(race)
end
function c511000210.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,1-tp,false,false,POS_FACEUP) 
		and Duel.IsExistingMatchingCard(c511000210.cfilter,tp,0,LOCATION_MZONE,1,nil,c:GetRace())
end
function c511000210.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(1-tp) 
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCanBeSpecialSummoned,tp,0,LOCATION_DECK,1,nil,e,0,1-tp,false,false,POS_FACEUP) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,1-tp,LOCATION_DECK)
end
function c511000210.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft=1 end
	local sg=Duel.SelectMatchingCard(1-tp,c511000210.spfilter,1-tp,LOCATION_DECK,0,ft,ft,nil,e,tp)
	if sg:GetCount()>0 and Duel.SpecialSummon(sg,0,1-tp,1-tp,false,false,POS_FACEUP)>0 then
		local tc=sg:GetFirst()
		while tc do
			tc:RegisterFlagEffect(511000210,RESET_EVENT+0x1fe0000,0,0)
			tc=sg:GetNext()
		end
		sg:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetLabelObject(sg)
		e1:SetCondition(c511000210.discon)
		e1:SetOperation(c511000210.disop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000210.disfilter(c)
	return c:GetFlagEffect(511000210)>0
end
function c511000210.discon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511000210.disfilter,1,nil) then
		g:DeleteGroup()
		e:Reset()
		return false
	end
	return g:IsContains(re:GetHandler()) and re:GetCode()==EVENT_SPSUMMON_SUCCESS and Duel.IsChainDisablable(ev)
end
function c511000210.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
