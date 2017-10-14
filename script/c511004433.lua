--Lock Draw
function c511004433.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511004433.op)
	c:RegisterEffect(e1)
end
function c511004433.op(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	--cannot draw
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DRAW)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetValue(0)
	Duel.RegisterEffect(e2,tp)
	--send action card
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetCondition(c511004433.sacon1)
	e3:SetOperation(c511004433.sacop1)
	Duel.RegisterEffect(e3,1-tp)
	local e4=e3:Clone()
	e4:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e4:SetCondition(c511004433.sacon2)
	e4:SetOperation(c511004433.sacop2)
	Duel.RegisterEffect(e4,1-tp)
	--reset effect when send action card
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetLabelObject(e1)
	e5:SetCondition(c511004433.rescon)
	e5:SetOperation(c511004433.resop)
	Duel.RegisterEffect(e5,1-tp)
	local e6=e5:Clone()
	e6:SetLabelObject(e2)
	Duel.RegisterEffect(e6,1-tp)
	local e7=e5:Clone()
	e7:SetLabelObject(e3)
	Duel.RegisterEffect(e7,1-tp)
	local e8=e5:Clone()
	e8:SetLabelObject(e4)
	Duel.RegisterEffect(e8,1-tp)
end
function c511004433.cfilter(c,tp)
	return c:IsAbleToGrave() and c:IsSetCard(0xac1) and c:IsControler(tp)
end
function c511004433.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_HAND) and c:IsSetCard(0xac1) and c:IsControler(tp)
end
function c511004433.sacon1(e,tp,eg,ev,ep,re,r,rp)
	return eg and eg:IsExists(c511004433.cfilter,1,nil,tp)
end
function c511004433.sacop1(e,tp,eg,ev,ep,re,r,rp)
	if eg and eg:IsExists(c511004433.cfilter,1,nil,tp) and Duel.SelectYesNo(tp,504) then
		local egc=eg:FilterSelect(tp,c511004433.cfilter,1,1,nil,tp)
		Duel.SendtoGrave(egc,REASON_EFFECT)
	end
end
function c511004433.sacon2(e,tp,eg,ev,ep,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004433.cfilter,tp,LOCATION_HAND,LOCATION_HAND,1,nil,tp) and Duel.GetTurnPlayer()==tp
end
function c511004433.sacop2(e,tp,eg,ev,ep,re,r,rp)
	if Duel.IsExistingMatchingCard(c511004433.cfilter,tp,LOCATION_HAND,LOCATION_HAND,1,nil,tp) and Duel.SelectYesNo(tp,504) then
		local g=Duel.SelectMatchingCard(tp,c511004433.cfilter,tp,LOCATION_HAND,LOCATION_HAND,1,1,nil,tp)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c511004433.rescon(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511004433.filter,1,nil,tp)
end
function c511004433.resop(e,tp)
	local er=e:GetLabelObject()
	er:Reset()
	e:Reset()
end
