--Chronomaly Aztec Mask Golem
function c511023001.initial_effect(c)
	c:SetUniqueOnField(1,0,9900013)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511023001.hspcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(9900013,ACTIVITY_CHAIN,c511023001.chainfilter)
end
function c511023001.chainfilter(re,tp,cid)
	return not re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511023001.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetCustomActivityCount(9900013,tp,ACTIVITY_CHAIN)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>3
end
