--H・C ダブル・ランス
function c511002760.initial_effect(c)
	c511002760.xyzlimit2=function(mc) return mc:IsSetCard(0x206f) end
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
end
