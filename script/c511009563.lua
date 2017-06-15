--Challenge Stairs
--fixed by MLD
function c511009563.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--bounce
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4740489,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511009563.atcon)
	e3:SetCost(c511009563.atcost)
	e3:SetTarget(c511009563.attg)
	e3:SetOperation(c511009563.atop)
	c:RegisterEffect(e3)
end
function c511009563.atcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	return a:IsControler(tp) and a:IsRelateToBattle() and d:IsRelateToBattle() and d:IsLocation(LOCATION_ONFIELD)
end
function c511009563.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,Duel.GetAttacker()) end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,1,Duel.GetAttacker())
	if g:GetFirst()==e:GetHandler() then
		e:SetLabel(1)
	end
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009563.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
end
function c511009563.atop(e,tp,eg,ep,ev,re,r,rp)
	local label=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if label==0 and not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() then
		Duel.ChainAttack()
	end
end
