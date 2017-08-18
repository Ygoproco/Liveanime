--Yashinoki(DOR)
--scripted by GameMaster(GM)
function c511005694.initial_effect(c)
	--flip effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511005694.flipop)
	c:RegisterEffect(e1)
end

function c511005694.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Recover(tp,500,REASON_EFFECT)	
end
