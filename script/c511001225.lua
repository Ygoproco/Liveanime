--Xyz Crown
function c511001225.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_XYZ))
	--double xyz material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_RANK_LEVEL_S)
	c:RegisterEffect(e5)
end
