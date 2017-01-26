--Aqua Mirage
function c511001175.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	--xyz
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(511001175)
	e4:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e4)
end
