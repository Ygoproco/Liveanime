--Mysterious Monolith
function c511000510.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000510.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ADJUST)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c511000510.regop)
	c:RegisterEffect(e3)
end
function c511000510.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	while c:GetFlagEffect(511000189)<4 do
		c:RegisterFlagEffect(511000189,RESET_EVENT+0x1ff0000,0,0)
	end
end
