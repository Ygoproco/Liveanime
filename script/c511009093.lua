--Cipher Diffusion
--fixed by MLD
function c511009093.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009093.cost)
	e1:SetCondition(c511009093.condition)
	e1:SetTarget(c511009093.target)
	e1:SetOperation(c511009093.activate)
	c:RegisterEffect(e1)
end
function c511009093.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsAbleToEnterBP()
end
function c511009093.cfilter(c,tp)
	return c:IsFaceup() and c:IsAttackAbove(3000) and c:IsSetCard(0xe5) 
		and Duel.IsExistingTarget(c511009093.filter,tp,LOCATION_MZONE,0,1,c)
end
function c511009093.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009093.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511009093.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc=g:GetFirst()
	Duel.HintSelection(g)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1,true)
	e:SetLabelObject(tc)
end
function c511009093.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xe5) 
end
function c511009093.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009093.filter,tp,LOCATION_MZONE,0,1,tc) end
	e:SetLabelObject(nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tg=Duel.SelectTarget(tp,c511009093.filter,tp,LOCATION_MZONE,0,1,1,tc):GetFirst()
	Duel.SetTargetParam(tg:GetFieldID())
end
function c511009093.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c511009093.activate(e,tp,eg,ep,ev,re,r,rp)
	local label=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c511009093.ftarget)
	e1:SetLabel(label)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
