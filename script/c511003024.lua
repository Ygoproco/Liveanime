--ダーク・ヴァージャー
function c511003024.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c511003024.spcon)
	e1:SetTargetRange(POS_FACEUP_ATTACK,0)
	c:RegisterEffect(e1)
end
function c511003024.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:IsType(TYPE_TUNER)
end
function c511003024.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and	Duel.IsExistingMatchingCard(c511003024.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
