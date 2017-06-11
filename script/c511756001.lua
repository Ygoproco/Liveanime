--壺魔人
function c511756001.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(c511756001.regcon)
	e1:SetOperation(c511756001.regop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511756001.con)
	e2:SetTarget(c511756001.tg)
	e2:SetOperation(c511756001.op)
	c:RegisterEffect(e2)
end
function c511756001.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetPreviousPosition(),POS_DEFENSE)~=0 and c:IsFaceup() and c:IsAttackPos()
end
function c511756001.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511756001,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c511756001.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511756001)>0
end
function c511756001.filter(c)
	return c:IsFaceup() and c:IsCode(50045299) and c:GetOverlayGroup():IsExists(Card.IsRace,1,nil,RACE_DRAGON)
end
function c511756001.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511756001.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
end
function c511756001.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVEXYZ)
	local g=Duel.SelectMatchingCard(tp,c511756001.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local og=tc:GetOverlayGroup():Filter(Card.IsRace,nil,RACE_DRAGON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local sc=og:Select(tp,1,1,nil):GetFirst()
		Duel.MoveToField(sc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(c511756001.efilter)
		sc:RegisterEffect(e2)
	end
end
function c511756001.efilter(e,te)
	return te:GetHandler():IsCode(50045299)
end
