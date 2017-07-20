--Elemental HERO Necroshade
function c511023014.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511023014,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetCondition(c511023014.ntcon)
	e1:SetTarget(c511023014.nttg)
	e1:SetCategory(CATEGORY_SUMMON)
	c:RegisterEffect(e1)
end
function c511023014.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511023014.nttg(e,c)
	return c:IsSetCard(0x3008)
end