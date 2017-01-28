--Overlay Satellite
function c511001373.initial_effect(c)
	aux.AddEquipProcedure(c)
	--double xyz material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	--attach
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511001373,0))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(c511001373.atcon)
	e5:SetOperation(c511001373.atop)
	c:RegisterEffect(e5)
end
function c511001373.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_LOST_TARGET) and c:GetPreviousEquipTarget():IsLocation(LOCATION_OVERLAY)
end
function c511001373.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetPreviousEquipTarget():GetReasonCard()
	Duel.Overlay(rc,Group.FromCards(c))
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	rc:RegisterEffect(e1)
end
