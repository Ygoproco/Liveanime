--魂粉砕
--scripted by GameMaster(GM)
--fixed by MLD
function c511005641.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511005641.condition)
	e1:SetCost(c511005641.cost)
	e1:SetTarget(c511005641.target)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511005641,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_BOTH_SIDE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c511005641.rmcon)
	e2:SetCost(c511005641.rmcost)
	e2:SetTarget(c511005641.rmtg)
	e2:SetOperation(c511005641.rmop)
	c:RegisterEffect(e2)
end
function c511005641.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c511005641.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511005641.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511005641.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511005641.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local label=e:GetLabel()
	if chkc then return c511005641.tg(e,tp,eg,ep,ev,re,r,rp,0,chkc) end
	if chk==0 then
		if label==1 then e:SetLabel(0) end
		return true
	end
	if c511005641.rmcon(e,tp,eg,ep,ev,re,r,rp) and label==1 and c511005641.rmcost(e,tp,eg,ep,ev,re,r,rp,0) 
		and c511005641.rmtg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,65) then
		e:SetCategory(CATEGORY_REMOVE)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c511005641.rmop)
		c511005641.rmcost(e,tp,eg,ep,ev,re,r,rp,1)
		c511005641.rmtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511005641.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511005641.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	local lp=Duel.GetLP(tp)
	local ct=Duel.GetTargetCount(c511005641.rfilter,tp,0,LOCATION_GRAVE,nil)
	local t={}
	local l=1
	while l<ct and l*500<=lp do
		t[l]=l*500
		l=l+1
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(67196946,0))
	local announce=Duel.AnnounceNumber(tp,table.unpack(t))
	Duel.PayLPCost(tp,announce)
	e:SetLabel(announce/500)
end
function c511005641.rfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511005641.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c511005641.rfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511005641.rfilter,tp,0,LOCATION_GRAVE,1,nil) end
	local ct=e:GetLabel()
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511005641.rfilter,tp,0,LOCATION_GRAVE,ct,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511005641.rmop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
