--Galaxy Knight
--fixed by MLD
function c511013032.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511013032.spcon)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511013032.atcon)
	c:RegisterEffect(e2)
end
function c511013032.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511013032.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511013032.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,35950025)
end
function c511013032.atcon(e)
	local c=e:GetHandler()
 	return Duel.IsExistingMatchingCard(c511013032.cfilter,c:GetControler(),LOCATION_MZONE,0,1,c,c:GetCode())
end
