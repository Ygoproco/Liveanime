--Commande duel 13
function c95200013.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200013.target)
	e1:SetOperation(c95200013.operation)
	c:RegisterEffect(e1)
end
function c95200013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c95200013.operation(e,tp,eg,ep,ev,re,r,rp)
	--[[local p=Duel.RockPaperScissors()
	Duel.Draw(p,1,REASON_EFFECT)]]
end
