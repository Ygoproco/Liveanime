--Supreme King Servant Dragon Dark Rebellion
function c511009508.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
		--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000369,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511009508.spcon)
	e1:SetTarget(c511009508.sptg)
	e1:SetOperation(c511009508.spop)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetValue(c511009508.atlimit)
	c:RegisterEffect(e2)
	--atk change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(93717133,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetHintTiming(TIMING_BATTLE_PHASE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c511009508.atkcost)
	e3:SetCondition(c511009508.atkcon)
	e3:SetTarget(c511009508.atktg)
	e3:SetOperation(c511009508.atkop)
	c:RegisterEffect(e3)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c511009508.spcost)
	e4:SetTarget(c511009508.sptg2)
	e4:SetOperation(c511009508.spop2)
	c:RegisterEffect(e4)
end
----------------------------------
function c511009508.sfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_XYZ) and c:GetSummonType()==SUMMON_TYPE_XYZ
end
function c511009508.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009508.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009508.sfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511009508.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511009508.mfilter(c)
	return c:IsFaceup() and not c:IsType(TYPE_TOKEN)
end
function c511009508.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	-- local g=Duel.GetMatchingGroup(c511009508.mfilter,tp,LOCATION_MZONE,0,nil)
	-- if chk==0 then return c:IsXyzSummonable(g) end
	if chk==0 then return c:IsXyzSummonable(nil) end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511009508.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.XyzSummon(tp,c,nil)
	end
end
------------------------------------
function c511009508.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c~=e:GetHandler()
end
---------------------------------
function c511009508.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511009508.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511009508.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 and not c:IsHasEffect(511009518)  then return bc and bc:IsOnField() and bc:IsCanBeEffectTarget(e) end
	if chk==0 and c:IsHasEffect(511009518)  then return bc end
	if not c:IsHasEffect(511009518) then
	e.SetProperty(e,EFFECT_FLAG_CARD_TARGET)
	Duel.SetTargetCard(bc)
	end
	if c:IsHasEffect(511009518) then
	e.SetProperty(e,0)
	end
	-- local g=Group.FromCards(c,bc)
end
function c511009508.atkfilter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c511009508.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsHasEffect(511009518) then
	local tc=Duel.GetFirstTarget()
		if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
			local atk=tc:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(0)
			tc:RegisterEffect(e1)
			if c:IsRelateToEffect(e) and c:IsFaceup() then
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_UPDATE_ATTACK)
				e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				e2:SetValue(atk)
				c:RegisterEffect(e2)
			end
		end
	else
		local g=Duel.GetMatchingGroup(c511009508.atkfilter,tp,0,LOCATION_MZONE,nil)
		local tc=g:GetFirst()
		while tc do
			local atk=tc:GetAttack()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(0)
			tc:RegisterEffect(e1)
			if c:IsRelateToEffect(e) and c:IsFaceup() then
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_SINGLE)
				e2:SetCode(EFFECT_UPDATE_ATTACK)
				e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				e2:SetValue(atk)
				c:RegisterEffect(e2)
			end
			tc=g:GetNext()
		end	
	end
	e.SetProperty(e,EFFECT_FLAG_CARD_TARGET)
end

	

-----------------------------
function c511009508.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,0,REASON_COST)
end
function c511009508.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x21fb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009508.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009508.spfilter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009508.spfilter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c511009517.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511009508.spop2(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if g:GetCount()<=ft then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then 
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
