--Defend Slime
function c511000248.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c511000248.target)
	c:RegisterEffect(e1)
	--Slime's Defense
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000248,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511000248.atktg)
	e2:SetOperation(c511000248.atkop)
	c:RegisterEffect(e2)
	if not c511000248.global_check then
		c511000248.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511000248.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000248.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511000248.filter(c)
	return c:IsFaceup() and c420.IsSlime(c) and c~=Duel.GetAttackTarget() and c~=Duel.GetAttacker()
end
function c511000248.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000248.filter(chkc) end
	if chk==0 then return true end
	if Duel.CheckEvent(EVENT_BE_BATTLE_TARGET) and Duel.IsExistingTarget(c511000248.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
		and Duel.SelectYesNo(tp,94) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c511000248.atkop)
		c511000248.atktg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000248.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000248.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(511000248)==0 end
	e:GetHandler():RegisterFlagEffect(511000248,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000248.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511000248.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
