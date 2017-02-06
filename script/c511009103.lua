--Fast Chant
--fixed by MLD
function c511009103.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009103.cost)
	e1:SetTarget(c511009103.target)
	e1:SetOperation(c511009103.activate)
	c:RegisterEffect(e1)
end
function c511009103.cfilter(c,e)
	local te,eg,ep,ev,re,r,rp=c:CheckActivateEffect(true,true,true)
	if not te then return false end
	local target=te:GetTarget()
	return c:GetType()==TYPE_SPELL and c:IsAbleToGraveAsCost() and (not target or target(e,tp,eg,ep,ev,re,r,rp,0))
end
function c511009103.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511009103.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511009103.cfilter,tp,LOCATION_HAND,0,1,nil,e)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511009103.cfilter,tp,LOCATION_HAND,0,1,1,nil,e)
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	local te=g:GetFirst():CheckActivateEffect(true,true,false)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	e:SetLabelObject(te)
end
function c511009103.activate(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c511009103.accon)
	e1:SetValue(c511009103.aclimit)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function c511009103.accon(e)
	return e:GetLabel()~=Duel.GetTurnCount() and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function c511009103.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
