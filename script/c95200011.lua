--Commande duel 11
function c95200011.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200011.target)
	e1:SetOperation(c95200011.operation)
	c:RegisterEffect(e1)
end
function c95200011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,PLAYER_ALL,2000)
end
function c95200011.operation(e,tp,eg,ep,ev,re,r,rp)
	--[[local p=Duel.RockPaperScissors()
	Duel.Recover(p,2000,REASON_EFFECT)]]
end
