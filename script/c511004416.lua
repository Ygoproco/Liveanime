--Performapal Guard Dance
function c511004416.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511004416.operation)
	c:RegisterEffect(e1)
	--rem
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c511004416.tg)
	e2:SetOperation(c511004416.op)
	c:RegisterEffect(e2)
end
function c511004416.operation(e,tp,eg,ev,ep,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x9f))
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c511004416.filter1(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f) and c:IsAbleToChangeControler() and c:IsFaceup() and c:GetBattledGroupCount()~=0
end
function c511004416.filter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToChangeControler() and c:IsFaceup()
end
function c511004416.tg(e,tp,eg,ev,ep,re,r,rp,chk)
	local no=Duel.GetMatchingGroupCount(c511004416.filter1,tp,LOCATION_MZONE,0,nil,e,tp)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004416.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004416.filter2,tp,0,LOCATION_MZONE,no,nil,e,tp) end
end
function c511004416.op(e,tp,eg,ev,ep,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511004416.filter1,tp,LOCATION_MZONE,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c511004416.filter2,tp,0,LOCATION_MZONE,nil,e,tp)
	if g2:GetCount()<g1:GetCount() then return end
	local gc1=nil
	if g1:GetCount()>1 then
		gc1=g1:Select(tp,1,1,nil):GetFirst()
	elseif g1:GetCount()==1 then
		gc1=g1:GetFirst()
	end
	if gc1 then g1:RemoveCard(gc1) end
	while gc1 and g2:GetCount()~=0 do
		local gc2=nil
		if g2:GetCount()>1 then
			gc2=g2:Select(tp,1,1,nil):GetFirst()
		else
			gc2=g2:GetFirst()
		end
		g2:RemoveCard(gc2)
		Duel.SwapControl(gc1,gc2)
		if g1:GetCount()>1 then
			gc1=g1:Select(tp,1,1,nil):GetFirst()
		elseif g1:GetCount()==1 then
			gc1=g1:GetFirst()
		else
			gc1=nil
		end
		if gc1 then g1:RemoveCard(gc1) end
	end
end
