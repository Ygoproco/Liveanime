--Abyss Costume - Shield of the Dwarf
function c511009082.initial_effect(c)
	aux.AddEquipProcedure(c)
	--DEF up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
