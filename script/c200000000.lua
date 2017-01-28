--希望の創造者
function c200000000.initial_effect(c)
	--register
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c200000000.regcon)
	e1:SetOperation(c200000000.regop)
	c:RegisterEffect(e1)
	--check 1st draw phase
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c200000000.regcon2)
	e2:SetOperation(c200000000.regop2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetCondition(c200000000.con)
	e3:SetCost(c200000000.cost)
	e3:SetTarget(c200000000.tg)
	e3:SetOperation(c200000000.op)
	c:RegisterEffect(e3)
end
c200000000.illegal=true
function c200000000.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()~=tp
end
function c200000000.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(200000000,RESET_EVENT+0x1fe0000,0,1)
end
function c200000000.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetFlagEffect(200000000)>0
end
function c200000000.regop2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(200000001,RESET_EVENT+0x1fe0000,0,1)
end
function c200000000.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<Duel.GetLP(1-tp) and e:GetHandler():GetFlagEffect(200000001)>0
end
function c200000000.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	c200000000.announce_filter={200000001,OPCODE_ISCODE,nil,OPCODE_ISCODE,OPCODE_NOT,OPCODE_AND}
	Duel.AnnounceCardFilter(tp,table.unpack(c200000000.announce_filter))
end
function c200000000.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c200000000.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(110000000,6))
	local tc=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(tp,1)
	end
	Duel.RegisterFlagEffect(tp,200000000,0,0,0)
end
