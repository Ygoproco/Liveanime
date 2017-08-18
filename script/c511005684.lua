--The wicked worm beast (DOR)
--scripted by GameMaster (GM)
function c511005684.initial_effect(c)
	--Destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511005684.desreptg)
	c:RegisterEffect(e1)
end

function c511005684.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) end
		Duel.SendtoDeck(c,tp,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
end
