--Lightning Saber
--Scripted by eclair11
--fixed by MLD
function c511009203.initial_effect(c)
	aux.AddEquipProcedure(c)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--chain attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511009203.chcon)
	e4:SetOperation(c511009203.chop)
	c:RegisterEffect(e4)
end
function c511009203.chcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget():IsStatus(STATUS_OPPO_BATTLE)
end
function c511009203.chop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or not tc then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(tc:GetAttack()/2)
	tc:RegisterEffect(e1)
	Duel.ChainAttack()
end
