--Supreme King Servant Dragon Darkvrm (Anime)
function c511009442.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--negate attack Pendulum Zone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80538728,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009442.condition)
	e1:SetOperation(c511009442.operation)
	c:RegisterEffect(e1)
	--negate attack Monster Zone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27143874,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetCondition(c511009442.con)
	e2:SetOperation(c511009442.operation)
	c:RegisterEffect(e2)
end
function c511009442.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsFaceup() and c:IsSetCard(0xf8)
end
function c511009442.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511009442.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xf8)
end
function c511009442.con(e)
	return Duel.GetAttackTarget()==e:GetHandler() and Duel.IsExistingMatchingCard(c511009442.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
