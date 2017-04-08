--D/D Savant Albert
function c511015102.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015102,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511015102.target)
	e1:SetOperation(c511015102.operation)
	c:RegisterEffect(e1)
	
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015102,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511015102.setcon)
	e2:SetCost(c511015102.setcost)
	e2:SetOperation(c511015102.setop)
	c:RegisterEffect(e2)
end
function c511015102.filter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsAbleToHand()
end
function c511015102.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chck:IsLocation(LOCATION_SZONE) and c511015102.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511015102.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511015102.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511015102.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		
		--cannot activate
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCode(EFFECT_CANNOT_ACTIVATE)
		e2:SetRange(LOCATION_HAND)
		e2:SetTargetRange(LOCATION_HAND,0)
		e2:SetValue(c511015102.aclimit)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c511015102.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler()==e:GetHandler()
end

function c511015102.setcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511015102.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and Duel.IsExistingMatchingCard(Card.IsSSetable,tp,LOCATION_HAND,0,1,nil) end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511015102.setop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsSSetable,tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.SSet(tp,tc)
		
		tc:SetStatus(STATUS_SET_TURN,false)
		e:GetHandler():CreateRelation(tc,RESET_EVENT+0x1fe0000)
		Duel.RaiseEvent(tc,EVENT_SSET,e,REASON_EFFECT,tp,tp,0)
	end
end