--オネスト
--fixed by MLD
function c511021006.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(511021006,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511021006.thtg)
	e1:SetOperation(c511021006.thop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetDescription(aux.Stringid(511021006,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511021006.atkcon)
	e2:SetCost(c511021006.atkcost)
	e2:SetTarget(c511021006.atktg)
	e2:SetOperation(c511021006.atkop)
	c:RegisterEffect(e2)
end
function c511021006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511021006.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
function c511021006.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511021006.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511021006.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(7) and c:IsRace(RACE_WARRIOR)
end
function c511021006.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511021006.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511021006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511021006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511021006.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local bc=tc:GetBattleTarget()
		if bc and bc:IsRelateToBattle() and bc:IsControler(1-tp) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(bc:GetAttack())
			tc:RegisterEffect(e1)
			bc:RegisterFlagEffect(511021006,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,0)
		end
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EVENT_ADJUST)
		e2:SetRange(LOCATION_MZONE)	
		e2:SetOperation(c511021006.atkup)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end
function c511021006.atkup(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetOwner()
	local tc=e:GetHandler()
	local bc=tc:GetBattleTarget()
	if not bc or bc:GetFlagEffect(511021006)>0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(bc:GetAttack())
	tc:RegisterEffect(e1)
	bc:RegisterFlagEffect(511021006,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,0)
end
