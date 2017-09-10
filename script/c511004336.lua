--Capture Snare
--scripted by andré
--fixed by MLD
function c511004336.initial_effect(c)
	--atk stop
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511004336.condition)
	e1:SetTarget(c511004336.tg)
	e1:SetOperation(c511004336.op)
	c:RegisterEffect(e1)  
end
function c511004336.filter(c)
	return c:GetCounter(0x1107)>0
end
function c511004336.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.IsExistingMatchingCard(c511004336.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511004336.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c511004336.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.MoveToField(Duel.GetAttacker(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.GetAttacker():AddCounter(0x1107,1)
	end
end
