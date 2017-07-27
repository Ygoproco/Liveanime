--Type Zero Magic crusher (DOR)
--scripted by GameMaster (GM)
function c511005664.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511005664.condition)
	e1:SetTarget(c511005664.target)
	e1:SetOperation(c511005664.activate)
	c:RegisterEffect(e1)
end
function c511005664.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and re:GetOwnerPlayer()~=tp
end

function c511005664.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end

function c511005664.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
