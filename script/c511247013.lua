--Heartfelt Appeal (Anime)
function c511247013.initial_effect(c)
		--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511247013.ctlcon)
	e1:SetTarget(c511247013.ctltg)
	e1:SetOperation(c511247013.ctlop)
	c:RegisterEffect(e1)
end
function c511247013.ctlcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetAttackTarget()==nil and Duel.GetAttacker():IsControler(1-tp)
end
function c511247013.ctltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c511247013.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local sg=g:GetMaxGroup(Card.GetDefense)
	if sg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		sg=sg:Select(tp,1,1,nil)
	end
	local tc=sg:GetFirst()
	Duel.GetControl(tc,1-tp,PHASE_STANDBY)
end
