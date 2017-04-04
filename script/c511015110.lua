--Battleguard Rage (Anime)
function c511015110.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511015110.condition)
	e1:SetTarget(c511015110.target)
	e1:SetOperation(c511015110.activate)
	c:RegisterEffect(e1)
	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511015110.descon)
	e2:SetOperation(c511015110.desop)
	c:RegisterEffect(e2)
end
function c511015110.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511015110.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x2310) or c:IsCode(39389320) or c:IsCode(40453765) or c:IsCode(20394040))
end
function c511015110.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511015110.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511015110.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511015110.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511015110.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCondition(c511015110.rcon)
		e1:SetValue(2000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
		e2:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e2:SetCondition(c511015110.rcon)
		e2:SetValue(LOCATION_HAND)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end
function c511015110.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511015110.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511015110.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
