--Scrubbed Raid (Anime)
--AlphaKretin
--fixed by MLD
function c511310004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511310004.accost)
	e1:SetTarget(c511310004.target)
	c:RegisterEffect(e1)
	--instant(chain)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79205581,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetLabel(0)
	e2:SetCondition(c511310004.con)
	e2:SetTarget(c511310004.cost)
	e2:SetTarget(c511310004.tg)
	e2:SetOperation(c511310004.op)
	c:RegisterEffect(e2)
end
function c511310004.accost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511310004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local label=e:GetLabel()
	if chk==0 then
		if label==1 then e:SetLabel(0) end
		return true
	end
	if Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE 
		and (label~=1 or c511310004.cost(e,tp,eg,ep,ev,re,r,rp,0)) 
		and c511310004.tg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,65) then
		e:SetOperation(c511310004.op)
		if label==1 then
			c511310004.cost(e,tp,eg,ep,ev,re,r,rp,1)
		end
		c511310004.tg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetOperation(nil)
	end
end
function c511310004.con(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511310004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetFirst()==e:GetHandler() then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
	Duel.SendtoGrave(g,REASON_COST)
end
function c511310004.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local label=e:GetLabel()
	e:SetLabel(0)
	Duel.SetTargetParam(label)
end
function c511310004.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) and Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)==0 then return end
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
