--天輪の葬送士
function c100000481.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000481.spcon)
	c:RegisterEffect(e1)
end
c100000481.celestial_collection={
	[69865139]=true;[25472513]=true;
}
function c100000481.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x2407) or c100000481.celestial_collection[c:GetCode()]) and c:IsType(TYPE_MONSTER)
end
function c100000481.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000481.filter,tp,LOCATION_MZONE,0,1,nil)
end
