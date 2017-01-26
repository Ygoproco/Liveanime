--Tachyon Cannon
function c511001485.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511001485.filter)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(-500)
	c:RegisterEffect(e2)
	--attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511001485.atcon)
	e4:SetCost(c511001485.atcost)
	e4:SetOperation(c511001485.atop)
	c:RegisterEffect(e4)
end
function c511001485.filter(c)
	return c:IsCode(88177324) or c:IsCode(68396121)
end
function c511001485.atcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	return eq:IsRelateToBattle() and Duel.GetAttacker()==eq and eq:GetAttack()>=500
end
function c511001485.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_EQUIP)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(c511001485.value)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e1)
end
function c511001485.value(e,c)
	return c:GetAttack()/2
end
function c511001485.atop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	if not eq:IsRelateToBattle() then return end
	Duel.ChainAttack()
end
