--Raidraptor - Final Fortress Falcon
function c511009567.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),12,3)
	c:EnableReviveLimit()
	
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33334269,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG2_XMDETACH+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c511009567.cost)
	e2:SetTarget(c511009567.target)
	e2:SetOperation(c511009567.operation)
	c:RegisterEffect(e2)
	--multi atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(56532353,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511009567.atkcon)
	e4:SetCost(c511009567.atkcost)
	e4:SetOperation(c511009567.atkop)
	c:RegisterEffect(e4)
end
function c511009567.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511009567.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0xba)
end
function c511009567.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511009567.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	local g=Duel.GetMatchingGroup(c511009567.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c511009567.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009567.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
	end
end
function c511009567.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a and a:IsRelateToBattle() and a:IsSetCard(0xba) and a:IsControler(tp)
end
function c511009567.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	local g=e:GetHandler():GetOverlayGroup()
	Duel.SendtoGrave(g,REASON_COST)
end
function c511009567.cfilter(c)
	return c:IsSetCard(0xba) and c:IsAbleToRemoveAsCost()
end
function c511009567.atkop(e,tp,eg,ep,ev,re,r,rp)
		local c=e:GetHandler()
		local a=Duel.GetAttacker()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_DAMAGE_STEP_END)
		e1:SetCondition(c511009567.atcon)
		e1:SetCost(c511009567.atcost)
		e1:SetOperation(c511009567.atop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		a:RegisterEffect(e1)
		if Duel.SelectYesNo(tp,94) and a:IsChainAttackable(0) and Duel.IsExistingMatchingCard(c511009567.cfilter,tp,LOCATION_GRAVE,0,1,nil) then
			local g=Duel.SelectMatchingCard(tp,c511009567.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
			if Duel.Remove(g,POS_FACEUP,REASON_COST) then
				Duel.ChainAttack()
			end
		end
end
function c511009567.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c and c:IsChainAttackable(0)
end
function c511009567.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009567.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511009567.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511009567.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end