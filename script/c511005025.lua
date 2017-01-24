--Bracer of Power
--  By Shad3
--cleaned and updated up by MLD
function c511005025.initial_effect(c)
	aux.AddEquipProcedure(c)
	--ATK
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(500)
	c:RegisterEffect(e3)
end
