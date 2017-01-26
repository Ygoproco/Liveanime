--ダブルフィン・シャーク
function c511002759.initial_effect(c)
	c511002759.xyzlimit2=function(mc) return mc:IsAttribute(ATTRIBUTE_WATER) end
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
end
