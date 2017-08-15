--Red Supremacy
function c511001653.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001653.cost)
	e1:SetTarget(c511001653.target)
	e1:SetOperation(c511001653.activate)
	c:RegisterEffect(e1)
end
function c511001653.cfilter(c)
	return c:IsSetCard(0x1045) and c:IsAbleToRemoveAsCost()
end
function c511001653.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001653.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001653.cfilter,tp,LOCATION_GRAVE,0,1,nil) 
			and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001653.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local code=g:GetFirst():GetOriginalCode()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetTargetParam(code)
end
function c511001653.activate(e,tp,eg,ep,ev,re,r,rp)
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		tc:CopyEffect(70902743,RESET_EVENT+0x1fe0000,1)
	end
end
