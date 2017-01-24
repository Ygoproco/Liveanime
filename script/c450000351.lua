--磁石の鱗獣Ｚ
function c450000351.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c450000351.atkcon)
	e1:SetOperation(c450000351.atkop)
	c:RegisterEffect(e1)
end
function c450000351.filter(c)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP) 
		and (c:IsSetCard(0x800) or c:IsSetCard(0x2066))
end
function c450000351.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c450000351.filter,1,nil)
end
function c450000351.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
