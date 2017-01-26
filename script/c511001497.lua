--Guardian Shield
function c511001497.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x52))
	--Def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c511001497.reptg)
	e4:SetValue(c511001497.repval)
	e4:SetOperation(c511001497.repop)
	c:RegisterEffect(e4)
end
function c511001497.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x52) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsReason(REASON_BATTLE)
end
function c511001497.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c511001497.repfilter,1,nil,tp) and c 
		and not c:IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(67616300,1))
end
function c511001497.repval(e,c)
	return c511001497.repfilter(c,e:GetHandlerPlayer())
end
function c511001497.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
