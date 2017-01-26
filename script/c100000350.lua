--氷炎の世界
function c100000350.initial_effect(c)
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
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)	
	e2:SetTarget(c100000350.target)
	c:RegisterEffect(e2)
end
function c100000350.target(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup()
end
