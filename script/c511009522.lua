--Supreme King Servant Dragon Odd eyes
--fixed by MLD
function c511009522.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_DECK+LOCATION_EXTRA+LOCATION_HAND)
	e1:SetCondition(c511009522.spcon)
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
	e4:SetCondition(c511009522.damcon)
	e4:SetOperation(c511009522.damop)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(95923441,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetHintTiming(0,TIMING_END_PHASE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCost(c511009522.spcost)
	e5:SetTarget(c511009522.sptg)
	e5:SetOperation(c511009522.spop2)
	c:RegisterEffect(e5)
	--Peffect
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(52352005,0))
	e6:SetCategory(CATEGORY_TODECK)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCost(c511009522.pencost)
	e6:SetTarget(c511009522.pentg)
	e6:SetOperation(c511009522.penop)
	c:RegisterEffect(e6)
end
function c511009522.spfilter(c,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_PENDULUM) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c511009522.cfilter(c)
	return c:IsFaceup() and c:IsCode(13331639)
end
function c511009522.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009522.spfilter,1,nil,tp) and Duel.IsExistingMatchingCard(c511009522.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.CheckReleaseGroup(tp,Card.IsSetCard,2,nil,0x20f8) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function c511009522.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.CheckReleaseGroup(tp,Card.IsSetCard,2,nil,0x20f8) and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.SelectYesNo(tp,aux.Stringid(4003,8)) then
		local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,2,2,nil,0x20f8)
		Duel.Release(g,REASON_COST)
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511009522.indfilter(c)
	return c:IsFaceup() and c:IsOnField() and c:IsType(TYPE_PENDULUM) 
end
function c511009522.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511009522.indfilter,1,nil) end
	return true
end
function c511009522.indval(e,c)
	return c511009522.indfilter(c)
end
function c511009522.atlimit(e,c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c~=e:GetHandler()
end
function c511009522.damcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a:IsControler(tp) and a:IsType(TYPE_PENDULUM)) or (d and d:IsControler(tp) and d:IsType(TYPE_PENDULUM))
end
function c511009522.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev*2)
end
function c511009522.spfilter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x20f8) and c:IsType(TYPE_PENDULUM) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009522.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckOrExtraAsCost() 
		and Duel.IsExistingMatchingCard(c511009522.spfilter2,tp,LOCATION_EXTRA,0,2,e:GetHandler(),e,tp) end
	Duel.SendtoExtraP(e:GetHandler(),nil,REASON_COST)
end
function c511009522.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():GetFlagEffect(511009522)==0 end
	e:GetHandler():RegisterFlagEffect(511009522,RESET_CHAIN,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511009522.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) or Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c511009522.spfilter2,tp,LOCATION_EXTRA,0,e:GetHandler(),e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		local ag=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=ag:GetFirst()
		while tc do
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_ATTACK_FINAL)
			e2:SetValue(0)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			tc=ag:GetNext()
		end
	end
end
function c511009522.pencost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x20f8) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x20f8)
	Duel.Release(g,REASON_COST)
end
function c511009522.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeck() or e:GetHandler():IsAbleToExtra() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c511009522.penop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoExtraP(e:GetHandler(),nil,REASON_EFFECT)
	end
end
