--Domain of the Dark Ruler
function c513000131.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c513000131.condition)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0xff,0xff)
	e2:SetTarget(c513000131.disable)
	e2:SetCode(EFFECT_DISABLE) 
	c:RegisterEffect(e2)
end
function c513000131.condition(e,tp,eg,ev,ep,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsControler(1-tp)
end
function c513000131.disable(e,c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
