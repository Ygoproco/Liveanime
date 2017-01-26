--Orichalcos Sword of Sealing
function c511001650.initial_effect(c)
	aux.AddEquipProcedure(c,nil,nil,nil,c511001650.cost)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
	if not c511001650.global_check then
		c511001650.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DRAW)
		ge1:SetOperation(c511001650.op)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511001650.cfilter(c)
	return c:GetFlagEffect(511001650)>0 and c:IsDiscardable()
end
function c511001650.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001650.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511001650.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511001650.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg
	local tc=g:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511001650,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		tc=g:GetNext()
	end
end
