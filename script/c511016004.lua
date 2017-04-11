--BK ヘッドギア
function c511016004.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c511016004.valcon)
	c:RegisterEffect(e1)
end
function c511016004.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
