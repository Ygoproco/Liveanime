--Red Armor
function c511018006.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCondition(c511018006.condition)
	e1:SetOperation(c511018006.operation)
	c:RegisterEffect(e1)
	--batturo
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c511018006.target)
	e2:SetOperation(c511018006.operationb)
	c:RegisterEffect(e2)
	if not c511018006.global_check then
		c511018006.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511018006.archchk)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511018006.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511018006.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c420.IsRed(c) and c:IsFaceup() and c:IsControler(tp)
end
function c511018006.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511018006.filter,1,nil,tp)
end
function c511018006.operation(e,tp,eg,ev,ep,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(c420.IsRed))
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511018006.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511018006.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.SelectTarget(tp,c511018006.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c511018006.operationb(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end