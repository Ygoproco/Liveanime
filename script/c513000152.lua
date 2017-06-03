--Speed Spell - Silver Contrails (Anime)
--Ｓｐ－シルバー・コントレイル
--scripted by Larry126
function c513000152.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000152.con)
	e1:SetTarget(c513000152.target)
	e1:SetOperation(c513000152.activate)
	c:RegisterEffect(e1)
end
function c513000152.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>4
end
function c513000152.filter(c)
	return c:IsFaceup() and c:IsAttackable(ATTRIBUTE_WIND)
end
function c513000152.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c513000152.filter,tp,LOCATION_MZONE,0,1,nil) end
	return true
end
function c513000152.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c513000152.filter,tp,LOCATION_MZONE,0,nil)	  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tdg=dg:Select(tp,1,1,nil)
	local tc=tdg:GetFirst() 
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c513000152.atkcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
	end
end
function c513000152.atkcon(e)
	return bit.band(Duel.GetCurrentPhase(),0x38)~=0
end