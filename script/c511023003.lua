--Battlin' Boxer Sparrer
function c511023003.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511023003.spcon)
	e1:SetOperation(c511023003.spop)
	c:RegisterEffect(e1)
end
function c511023003.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x84)
end
function c511023003.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c511023003.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
