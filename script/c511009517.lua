--Supreme King Servant Dragon Clear Wing
function c511009517.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000369,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_EXTRA+LOCATION_GRAVE)
	e1:SetCondition(c511009517.spcon)
	e1:SetTarget(c511009517.sptg)
	e1:SetOperation(c511009517.spop)
	c:RegisterEffect(e1)
	--spsummon success
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511009517.effcon)
	e2:SetTarget(c511009517.distg)
	e2:SetOperation(c511009517.disop)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c511009517.atlimit)
	c:RegisterEffect(e3)
	--Destroy and damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_EQUIP)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c511009517.condition)
	e4:SetTarget(c511009517.target)
	e4:SetOperation(c511009517.operation)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetHintTiming(0,TIMING_END_PHASE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c511009517.spcost)
	e5:SetTarget(c511009517.sptg2)
	e5:SetOperation(c511009517.spop2)
	c:RegisterEffect(e5)
end
function c511009517.sfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_SYNCHRO) and c:GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c511009517.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009517.spfilter(c)
	return c:IsSetCard(0x20f8)
end
function c511009517.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009517.sfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511009517.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
	and Duel.CheckReleaseGroup(tp,Card.IsSetCard,2,nil,0x20f8)
end
function c511009517.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511009517.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,2,2,nil,0x20f8)
		if Duel.Release(g,REASON_COST) then
			Duel.SpecialSummon(c,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c511009517.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c511009517.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c511009517.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.Destroy(g,REASON_EFFECT)
end
function c511009517.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c~=e:GetHandler()
end
function c511009517.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d and a:GetControler()~=d:GetControler() and (a==c or d==c) then
		if d==c then e:SetLabelObject(a)
		else e:SetLabelObject(d) end
		return true
	else return false end
end
function c511009517.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 and not c:IsHasEffect(511009518) then return tc:IsOnField() and tc:IsCanBeEffectTarget(e) end
	if chk==0 and c:IsHasEffect(511009518)  then return tc end
	if not c:IsHasEffect(511009518) then
	e.SetProperty(e,EFFECT_FLAG_CARD_TARGET)
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
	end
	if c:IsHasEffect(511009518) then
	e.SetProperty(e,0)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	end
end
function c511009517.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsHasEffect(511009518) then
		local tc=Duel.GetFirstTarget()
		if Duel.NegateAttack() and Duel.Destroy(tc,REASON_EFFECT)>0 then
			if c:IsRelateToEffect(e) and c:IsFaceup() then
				local atk=tc:GetPreviousAttackOnField()
				if atk<=0 then return end
				Duel.Damage(1-tp,atk,REASON_EFFECT)
			end
		end
		else
			local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
			if Duel.NegateAttack() and Duel.Destroy(g,REASON_EFFECT)>0 then
			local dg=Duel.GetOperatedGroup()
			local tc=dg:GetFirst()
			local dam=0
			
			while tc do
			local atk=tc:GetPreviousAttackOnField()
			if atk<0 then atk=0 end
				dam=dam+atk
				tc=dg:GetNext()
			end
			if c:IsRelateToEffect(e) and c:IsFaceup() then
				if dam<=0 then return end
				Duel.Damage(1-tp,dam,REASON_EFFECT)
			end
		end
	end
	e.SetProperty(e,EFFECT_FLAG_CARD_TARGET)
end
function c511009517.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function c511009517.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x20f8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009517.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009517.spfilter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009517.spfilter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c511009517.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511009517.spop2(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if g:GetCount()<=ft then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then 
			-- local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
			local g=Duel.GetMatchingGroup(c511009517.filter,tp,0,LOCATION_MZONE,nil)
			local tc=g:GetFirst()
			while tc do
				local e2=Effect.CreateEffect(e:GetHandler())
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_SET_ATTACK_FINAL)
				e2:SetValue(0)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e2)
				tc=g:GetNext()
			end
		end
	end
end
