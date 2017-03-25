-- Performapal Odd-Eyes Minotaur
function c511009572.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93368494,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c511009572.atkupcon)
	e2:SetOperation(c511009572.atkupop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c511009572.atkcon)
	e3:SetTarget(c511009572.atktg)
	e3:SetValue(c511009572.atkval)
	c:RegisterEffect(e3)
end
function c511009572.atkupcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and (at:IsSetCard(0x9f) or at:IsSetCard(0x99))
end
function c511009572.atkupop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local at=Duel.GetAttacker()
	if at:IsFaceup() and at:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(100)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		at:RegisterEffect(e1)
	end
end
function c511009572.atkcon(e)
	local d=Duel.GetAttackTarget()
	local a=Duel.GetAttacker()
	local tp=e:GetHandlerPlayer()
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and d and d:IsControler(1-tp) and a and (a:IsSetCard(0x9f) or a:IsSetCard(0x99))
end
function c511009572.atktg(e,c)
	return c==Duel.GetAttackTarget() 
end
function c511009572.atkfilter(c)
	return c:IsFaceup() 
end
function c511009572.atkval(e,c)
	return Duel.GetMatchingGroupCount(c511009572.atkfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)*(-100)
end