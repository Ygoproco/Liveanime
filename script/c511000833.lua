--Immortal Homeostasis
function c511000833.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000833,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511000833.damcon)
	e1:SetOperation(c511000833.damop)
	c:RegisterEffect(e1)
end
function c511000833.damcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local p=eq:GetControler()
	return p==Duel.GetTurnPlayer() and eq:GetAttack()~=eq:GetBaseAttack()
end
function c511000833.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetEquipTarget():GetControler()
	Duel.Damage(p,300,REASON_EFFECT)
end
