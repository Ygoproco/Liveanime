--Engine Tuner
function c511002410.initial_effect(c)
	aux.AddEquipProcedure(c)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e3:SetCondition(c511002410.poscon)
	c:RegisterEffect(e3)
	--Atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c511002410.value)
	c:RegisterEffect(e4)
	--reset
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTarget(c511002410.desreptg)
	e5:SetOperation(c511002410.desrepop)
	c:RegisterEffect(e5)
end
function c511002410.poscon(e)
	return e:GetHandler():GetEquipTarget():IsPosition(POS_FACEUP_ATTACK)
end
function c511002410.value(e,c)
	return e:GetHandler():GetEquipTarget():GetDefense()/2
end
function c511002410.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	if chk==0 then return c:IsReason(REASON_LOST_TARGET) and ec and ec:IsReason(REASON_DESTROY) and c:IsCanTurnSet() end
	return true
end
function c511002410.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:CancelToGrave()
	Duel.ChangePosition(c,POS_FACEDOWN)
	Duel.RaiseEvent(c,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
end
