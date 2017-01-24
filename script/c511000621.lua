--Trust Chain
function c511000621.initial_effect(c)
	aux.AddPersistentProcedure(c,0,aux.FilterBoolFunction(Card.IsFaceup),CATEGORY_ATKCHANGE,EFFECT_FLAG_DAMAGE_STEP,TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP,c511000621.condition)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511000621.atktg)
	e1:SetValue(c511000621.atkval)
	c:RegisterEffect(e1)
	--instant(chain)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000621,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511000621.con)
	e2:SetTarget(c511000621.cost)
	e2:SetOperation(c511000621.op)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c511000621.atktarget)
	c:RegisterEffect(e3)
end
function c511000621.atktg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511000621.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511000621.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000621.atkval(e,c)
	local g=Duel.GetMatchingGroup(c511000621.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	return g:GetSum(Card.GetAttack)
end
function c511000621.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000621.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable(e) end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511000621.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
function c511000621.atktarget(e,c)
	return c:IsType(TYPE_SYNCHRO)
end
