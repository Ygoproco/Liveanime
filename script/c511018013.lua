--Performapal Pinch Helper (anime)
function c511018013.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511018013.condition)
	e1:SetTarget(c511018013.target)
	e1:SetOperation(c511018013.operation)
	c:RegisterEffect(e1)
	--halve battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511018013.hdcondition)
	e2:SetCost(c511018013.hdcost)
	e2:SetOperation(c511018013.hdoperation)
	c:RegisterEffect(e2)
end
function c511018013.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetAttacker() and Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511018013.spfilter(c,e,tp)
	return c:IsSetCard(0x9f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetAttack()<=800
end
function c511018013.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511018013.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) then
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
	end
end
function c511018013.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	if Duel.NegateAttack() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511018013.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511018013.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
		end
	end
end
function c511018013.hdcondition(e,tp)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	return a and d and a:GetControler()~=d:GetControler()
end
function c511018013.hdcost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511018013.hdoperation(e,tp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511018013.rdop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511018013.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,Duel.GetBattleDamage(tp)/2)
	Duel.ChangeBattleDamage(1-tp,Duel.GetBattleDamage(1-tp)/2)
end
