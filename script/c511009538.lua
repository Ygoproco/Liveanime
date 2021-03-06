--D/D Savant Schrödinger
--fixed by MLD
function c511009538.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99733359,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetTarget(c511009538.target)
	e1:SetOperation(c511009538.operation)
	c:RegisterEffect(e1)
	-- negate damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9106362,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c511009538.dmcon)
	e2:SetOperation(c511009538.dmop)
	c:RegisterEffect(e2)
end
function c511009538.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():GetFlagEffect(511009538)==0 
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	e:GetHandler():RegisterFlagEffect(511009538,RESET_PHASE+PHASE_DAMAGE,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009538.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--to be reupdated next core update
	if not c:IsRelateToEffect(e) then return end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511009538.damop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
	Duel.BreakEffect()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end
function c511009538.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511009538.dmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()
end
function c511009538.dmop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511009538.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
