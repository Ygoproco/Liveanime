--Cyberse Cache
--サイバース・キャッシュ
--scripted by Larry126
function c511600018.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511600018.condition)
	e1:SetTarget(c511600018.target)
	e1:SetOperation(c511600018.activate)
	c:RegisterEffect(e1)
end
function c511600018.filter(c)
	return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack() and c:IsRace(RACE_CYBERS)
end
function c511600018.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511600018.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c511600018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511600018.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
