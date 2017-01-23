--Performapal Guard Dance
function c511004416.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511004416.condition)
	e1:SetTarget(c511004416.target)
	e1:SetOperation(c511004416.operation)
	c:RegisterEffect(e1)
	--rem
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c511004416.cst)
	e2:SetTarget(c511004416.tg)
	e2:SetOperation(c511004416.op)
	c:RegisterEffect(e2)
end
function c511004416.filter1(c,e,tp)
	return c:IsControler(1-tp) and c:IsType(TYPE_MONSTER)
end
function c511004416.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg and eg:IsExists(c511004416.filter1,1,nil,e,tp) and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2
end
function c511004416.filter2(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f)
end
function c511004416.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return eg and eg:IsExists(c511004416.filter1,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004416.filter2,tp,LOCATION_MZONE,0,1,nil,e,tp) end
end
function c511004416.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetMatchingGroup(c511004416.filter2,tp,LOCATION_MZONE,0,nil,e,tp)
	local d=tg:GetFirst()
	while d do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		d:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		d:RegisterEffect(e2)
		d=tg:GetNext()
	end
end
function c511004416.cst(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),0,REASON_COST)
end
function c511004416.filter3(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x9f) and c:IsAbleToChangeControler() and c:GetBattledGroupCount()~=0
end
function c511004416.filter4(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToChangeControler()
end
function c511004416.tg(e,tp,eg,ev,ep,re,r,rp,chk)
	local no=Duel.GetMatchingGroupCount(c511004416.filter3,tp,LOCATION_MZONE,0,nil,e,tp)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004416.filter3,tp,LOCATION_MZONE,0,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004416.filter4,tp,0,LOCATION_MZONE,no,nil,e,tp) end
	local g1=Duel.GetMatchingGroup(c511004416.filter3,tp,LOCATION_MZONE,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c511004416.filter4,tp,0,LOCATION_MZONE,nil,e,tp)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
end
function c511004416.op(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g1=g:Filter(Card.IsControler,nil,tp):Filter(Card.IsAbleToChangeControler,nil)
	local g2=g:Filter(Card.IsControler,nil,1-tp):Filter(Card.IsAbleToChangeControler,nil)
	local gc1=nil
	if g1:GetCount()>1 then
		gc1=g1:FilterSelect(tp,Card.IsAbleToChangeControler,1,1,nil):GetFirst()
	elseif g1:GetCount()==1 then
		gc1=g1:GetFirst()
	end
	if gc1 then g1:RemoveCard(gc1) end
	while gc1 and g2:GetCount()~=0 do
		local gc2=nil
		if g2:GetCount()>1 then
			gc2=g2:FilterSelect(tp,Card.IsAbleToChangeControler,1,1,nil):GetFirst()
		else
			gc2=g2:GetFirst()
		end
		g2:RemoveCard(gc2)
		Duel.SwapControl(gc1,gc2)
		if g1:GetCount()>1 then
			gc1=g1:FilterSelect(tp,Card.IsAbleToChangeControler,1,1,nil):GetFirst()
		elseif g1:GetCount()==1 then
			gc1=g1:GetFirst()
		else
			gc1=nil
		end
		if gc1 then g1:RemoveCard(gc1) end
	end
end