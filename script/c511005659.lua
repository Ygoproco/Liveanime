--Celtic Guardian(DOR)
--scripted by GameMaster (GM)
function c511005659.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511005659.disop)
	e1:SetCondition(c511005659.condition)
	c:RegisterEffect(e1)
	--disable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_CHAIN_SOLVING)
	e10:SetRange(LOCATION_MZONE)
	e10:SetOperation(c511005659.disop)
	e10:SetCondition(c511005659.condition)
	c:RegisterEffect(e10)
end

function c511005659.disop(e,tp,eg,ep,ev,re,r,rp)
	tc=re:GetHandler()	
	if not Duel.GetOperationInfo(ev,CATEGORY_CONTROL) then return end
	Duel.NegateEffect(ev) 
end

function c511005659.condition(e,tp,eg,ep,ev,re,r,rp)
return re:IsActiveType(TYPE_TRAP+TYPE_SPELL+TYPE_MONSTER) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.GetOperationInfo(ev,CATEGORY_CONTROL) and e:GetHandler():IsDefensePos()
end















