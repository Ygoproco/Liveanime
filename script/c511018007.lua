--Predaplant Drosophyllum Hydra (Anime)
function c511018007.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99913726,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511018007.cost)
	e1:SetTarget(c511018007.atktg)
	e1:SetOperation(c511018007.atkop)
	c:RegisterEffect(e1)
	--halve battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(c511018007.cost)
	e2:SetCondition(c511018007.condition)
	e2:SetOperation(c511018007.operation)
	c:RegisterEffect(e2)
end
function c511018007.cfil(c)
	return c:IsSetCard(0x10f3) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c511018007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511018007.cfil,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511018007.cfil,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511018007.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511018007.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511018007.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511018007.filter(c)
	return c:IsSetCard(0x10f3) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c511018007.operation(e,tp,eg,ev,ep,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511018007.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetOperation(c511018007.damop)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511018007.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,Duel.GetBattleDamage(tp)/2)
end