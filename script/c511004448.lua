--Cold Performance
function c511004448.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511004448.condition)
	e1:SetTarget(c511004448.target)
	e1:SetOperation(c511004448.operation)
	c:RegisterEffect(e1)
end
function c511004448.filter(c,tp)
	return bit.band(c:GetPreviousTypeOnField(),TYPE_MONSTER)==TYPE_MONSTER and bit.band(c:GetPreviousTypeOnField(),TYPE_PENDULUM)==TYPE_PENDULUM and c:GetPreviousControler()==tp
end
function c511004448.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511004448.filter,1,nil,tp)
end
function c511004448.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	local lp=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rp=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	if chkc then return eg:IsExists(c511004448.filter,1,nil) and (lp==nil or rp==nil) end
	if chk==0 then return lp==nil or rp==nil end
	local tc=eg:FilterSelect(tp,c511004448.filter,1,1,nil,tp)
	Duel.SetTargetCard(tc)
end
function c511004448.operation(e,tp,eg,ev,ep,re,r,rp)
	local lp=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
	local rp=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
	if lp and rp then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetTargetRange(1,0)
		e1:SetValue(0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end  
end
