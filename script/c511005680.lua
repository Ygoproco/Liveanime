--Seal Of the anicients (DOR)
--scripted by GameMaster (GM)
function c511005680.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(c511005680.activate)
	e1:SetTarget(c511005680.target)
	e1:SetCondition(c511005680.condition)
	c:RegisterEffect(e1)
	--negate destroy ritual
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511005680.condition)
	e2:SetTarget(c511005680.target)
	e2:SetOperation(c511005680.activate)
	c:RegisterEffect(e2)
end

function c511005680.condition(e,tp,eg,ep,ev,re,r,rp)
return re:IsActiveType(TYPE_RITUAL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end

function c511005680.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end

function c511005680.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
