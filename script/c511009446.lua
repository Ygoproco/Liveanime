--D - Soul Burst
function c511009456.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009456.target)
	e1:SetOperation(c511009456.activate)
	c:RegisterEffect(e1)
end
function c511009456.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c511009456.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp)
		and chkc:IsLocation(LOCATION_MZONE)
		and c511009456.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c511009456.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009456.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511009456.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetAttack()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(atk/2)
		tc:RegisterEffect(e2)
		Duel.Damage(1-tp,atk/2,REASON_EFFECT)
	end
end