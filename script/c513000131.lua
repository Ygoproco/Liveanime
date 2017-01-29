--Domain of the Dark Ruler
function c513000131.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c513000131.condition)
	e1:SetTarget(c513000131.target)
	e1:SetOperation(c513000131.operation)
	c:RegisterEffect(e1)
end
function c513000131.condition(e,tp,eg,ev,ep,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and re:GetHandler():IsControler(1-tp)
end
function c513000131.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c513000131.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local chain=Duel.GetCurrentChain()-1
	if Duel.NegateActivation(chain) then
		local e1=Effect.CreateEffect(c)
		e1:SetCategory(CATEGORY_NEGATE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetRange(LOCATION_SZONE)
		e1:SetLabel(re:GetHandler():GetCode())
		e1:SetCondition(c513000131.conditions)
		e1:SetTarget(c513000131.targets)
		e1:SetOperation(c513000131.operations)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c513000131.conditions(e,tp,eg,ev,ep,re,r,rp)
	return e:GetLabel() and re:GetHandler():IsCode(e:GetLabel())
end
function c513000131.targets(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c513000131.operations(e,tp,eg,ev,ep,re,r,rp)
	local chain=Duel.GetCurrentChain()
	Duel.NegateActivation(chain)
end
