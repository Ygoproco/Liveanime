--Prophecy
function c511001120.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001120,0))
	e1:SetHintTiming(0,TIMING_TOHAND+TIMING_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001120.target)
	e1:SetOperation(c511001120.activate)
	c:RegisterEffect(e1)
end
function c511001120.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c511001120.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	local atk=tc:GetAttack()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511001120,0))
	local op=Duel.SelectOption(tp,aux.Stringid(4003,2),aux.Stringid(4003,3),aux.Stringid(4003,4))
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if (op==0 and atk<2000) or (op==1 and tc:GetAttack()==2000) or (op==2 and atk>2000) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
	end
end
