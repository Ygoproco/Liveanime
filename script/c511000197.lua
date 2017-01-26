--Drain Strike
function c511000197.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--half damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000197.atkcon)
	e3:SetOperation(c511000197.atkop)
	c:RegisterEffect(e3)
end
function c511000197.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	return ep~=tp and (eq==Duel.GetAttacker() or eq==Duel.GetAttackTarget()) and d:IsDefensePos() and eq:GetEffectCount(EFFECT_PIERCE)==1
end
function c511000197.atkop(e,tp,eg,ep,ev,re,r,rp)
	local dam=ev/2
	Duel.ChangeBattleDamage(ep,dam)
	if dam>0 then
		Duel.Recover(tp,dam,REASON_EFFECT)
	end
end
