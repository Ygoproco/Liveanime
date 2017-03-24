--Exchanging Notes
function c511004431.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511004431.condition)
	e1:SetTarget(c511004431.target)
	e1:SetOperation(c511004431.operation)
	c:RegisterEffect(e1)
end
function c511004431.conditionfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x21c)
end
function c511004431.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004431.conditionfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004431.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,0,0,0,2)
end
function c511004431.operation(e,tp,eg,ev,ep,re,r,rp)
	if Duel.Draw(tp,2,REASON_EFFECT)==2 then
		local g1=Duel.GetOperatedGroup()
		Duel.SendtoHand(g1,1-tp,REASON_EFFECT)
		local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
		Duel.ConfirmCards(tp,g2)
		g2=g2:Select(tp,2,2,nil)
		Duel.SendtoHand(g2,tp,REASON_EFFECT)
		g1:Merge(g2)
		g1:KeepAlive()
		--Return
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_BP)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		--cannot bp
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetLabelObject(g1)
		e2:SetCountLimit(1)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetOperation(c511004431.retoperation)
		Duel.RegisterEffect(e2,tp)
		--cannot Summon
		g1=g1:Filter(Card.IsType,nil,TYPE_MONSTER)
		local gc=g1:GetFirst()
		while gc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_SUMMON)
			e1:SetReset(RESET_PHASE+PHASE_END)
			gc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			gc:RegisterEffect(e2)
			gc=g1:GetNext()
		end
	end
end
function c511004431.retoperation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
	end
	g:DeleteGroup()
end
--0x21c "gut's master"