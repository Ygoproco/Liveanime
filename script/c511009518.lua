--Supreme King Violent Spirit
function c511009518.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511009518.filter)
	--Pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511009518)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511009518.eqlimit)
	c:RegisterEffect(e3)
end
function c511009518.eqlimit(e,c)
	return c:IsSetCard(0xf8) 
end
function c511009518.filter(c)
	return c:IsSetCard(0xf8) and c:IsFaceup() 
end
