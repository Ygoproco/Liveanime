--Hi-Speed Re-Level (Anime)
--AlphaKretin
--fixed by MLD
function c511310016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511310016.cost)
	e1:SetTarget(c511310016.target)
	e1:SetOperation(c511310016.activate)
	c:RegisterEffect(e1)
end
c511310016.check=false
function c511310016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	c511310016.check=true
	if chk==0 then return true end
end
function c511310016.cfilter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsSetCard(0x2016) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c511310016.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,lv)
end
function c511310016.filter(c,lv)
	local clv=c:GetLevel()
	return c:IsFaceup() and clv>0 and clv~=lv
end
function c511310016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if not c511310016.check then return false end
		c511310016.check=false
		return Duel.IsExistingMatchingCard(c511310016.cfilter,tp,LOCATION_GRAVE,0,1,nil,tp)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511310016.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	local lv=g:GetFirst():GetLevel()
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetTargetParam(lv)
end
function c511310016.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local sg=Duel.GetMatchingGroup(c511310016.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,lv)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
end
