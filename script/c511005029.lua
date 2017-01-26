--Magic Blade - Ice Sword
--  By Shad3
--cleaned and updated by MLD
function c511005029.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR))
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
end
