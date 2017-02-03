--Supreme King Servant Dragon Odd eyes
function c511009522.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000369,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_EXTRA+LOCATION_GRAVE+LOCATION_HAND)
	e1:SetCondition(c511009522.spcon)
	e1:SetTarget(c511009522.sptg)
	e1:SetOperation(c511009522.spop)
	c:RegisterEffect(e1)
	--replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009522.indtg)
	e2:SetValue(c511009522.indval)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c511009522.atlimit)
	c:RegisterEffect(e3)
	--double damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c511009522.condition)
	e4:SetOperation(c511009522.operation)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetHintTiming(0,TIMING_END_PHASE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c511009522.spcost)
	e5:SetTarget(c511009522.sptg2)
	e5:SetOperation(c511009522.spop2)
	c:RegisterEffect(e5)
	--Peffect
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(52352005,0))
	e6:SetCategory(CATEGORY_HANDES)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCost(c511009522.Pcost)
	e6:SetTarget(c511009522.Ptarget)
	e6:SetOperation(c511009522.Poperation)
	c:RegisterEffect(e6)
end
function c511009522.filter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_PENDULUM) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c511009522.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009522.spfilter(c)
	return c:IsSetCard(0x20f8)
end
function c511009522.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.CheckReleaseGroup(tp,Card.IsSetCard,2,nil,0x20f8)
	and Duel.IsExistingMatchingCard(c511009522.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
	and eg:IsExists(c511009522.filter,1,nil,tp) 
end
function c511009522.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511009522.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,2,2,nil,0x20f8)
		if Duel.Release(g,REASON_COST) then
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
function c511009522.indfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsOnField() and c:IsType(TYPE_PENDULUM) 
end
function c511009522.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511009522.indfilter,1,nil,tp) end
	return true
end
function c511009522.indval(e,c)
	return c511009522.indfilter(c,e:GetHandlerPlayer())
end
function c511009522.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c~=e:GetHandler()
end
function c511009522.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttacker():IsControler(tp) and Duel.GetAttacker():IsType(TYPE_PENDULUM)) or
	(Duel.GetAttackTarget():IsControler(tp) and Duel.GetAttackTarget():IsType(TYPE_PENDULUM))
end
function c511009522.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev*2)
end
function c511009522.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoExtraP(e:GetHandler(),tp,REASON_COST)
end
function c511009522.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x20f8) and c:IsType(TYPE_PENDULUM)  and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009522.sptg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingTarget(c511009522.spfilter,tp,LOCATION_EXTRA,0,2,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009522.spfilter,tp,LOCATION_EXTRA,0,2,2,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end

function c511009522.spop2(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if g:GetCount()<=ft then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP) then 
			local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
			-- local g=Duel.GetMatchingGroup(c511009522.filter,tp,0,LOCATION_MZONE,nil)
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
function c511009522.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x20f8) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x20f8)
	Duel.Release(g,REASON_COST)
end
function c511009522.Ptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c511009522.Poperation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
		Duel.SendtoExtraP(e:GetHandler(),tp,REASON_EFFECT)
end
