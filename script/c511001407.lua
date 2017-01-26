--Gagagamirage
function c511001407.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--xyz
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(511001225)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)	
	e2:SetTarget(c511001407.target)
	c:RegisterEffect(e2)
end
function c511001407.target(e,c)
	return c:IsSetCard(0x54) and c:IsFaceup()
end
