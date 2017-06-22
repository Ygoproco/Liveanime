--Performance Dragon's Shadow
--fixed by MLD
function c511004430.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511004430.condition)
	e1:SetCost(c511004430.cost)
	e1:SetTarget(c511004430.target)
	e1:SetOperation(c511004430.activate)
	c:RegisterEffect(e1)
end
function c511004430.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp) and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c511004430.cfilter(c,tp)
	return Duel.IsExistingTarget(c511004430.filter,tp,LOCATION_MZONE,0,1,c,tp,c)
end
function c511004430.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511004430.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c511004430.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c511004430.filter1(c,tp,rc)
	local g=Group.CreateGroup()
	if rc then
		g:AddCard(rc)
	end
	g:AddCard(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and Duel.IsExistingMatchingCard(c511004430.eqfilter,tp,LOCATION_MZONE,0,1,nil,g)
end
function c511004430.eqfilter(c,g)
	return not g:IsContains(c)
end
function c511004430.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511004430.filter(chkc) end
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():IsLocation(LOCATION_HAND) then
		ft=ft-1
	end
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c511004430.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511004430.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_MZONE)
end
function c511004430.activate(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetValue(1)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	Duel.RegisterEffect(e2,tp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,tc)
		local ec=g:GetFirst()
		if ec then
			Duel.HintSelection(g)
			local atk=ec:GetTextAttack()
			if ec:IsFacedown() or atk<0 then atk=0 end
			if Duel.Equip(tp,ec,tc,true) then
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_SINGLE)
				e3:SetCode(EFFECT_EQUIP_LIMIT)
				e3:SetReset(RESET_EVENT+0x1fe0000)
				e3:SetValue(c511004430.eqlimit)
				e3:SetLabelObject(tc)
				ec:RegisterEffect(e3)
				local e4=Effect.CreateEffect(c)
				e4:SetType(EFFECT_TYPE_EQUIP)
				e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
				e4:SetCode(EFFECT_UPDATE_ATTACK)
				e4:SetReset(RESET_EVENT+0x1fe0000)
				e4:SetValue(atk)
				ec:RegisterEffect(e4)
				local fid=c:GetFieldID()
				ec:RegisterFlagEffect(51104430,RESET_EVENT+0x1fe0000,0,1,fid)
				local e5=Effect.CreateEffect(c)
				e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e5:SetCode(EVENT_PHASE+PHASE_END)
				e5:SetCountLimit(1)
				e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
				e5:SetLabel(fid)
				e5:SetLabelObject(ec)
				e5:SetCondition(c511004430.spcon)
				e5:SetOperation(c511004430.spop)
				Duel.RegisterEffect(e5,tp)
			end
		end
	end
end
function c511004430.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511004430.spcon(e,tp,eg,ev,ep,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffectLabel(51104430)~=e:GetLabel() then
		e:Reset()
		return false
	else return true end
end
function c511004430.spop(e,tp,eg,ev,ep,re,r,rp)
	Duel.Hint(HINT_CARD,0,511004430)
	Duel.SpecialSummon(e:GetLabelObject(),0,tp,tp,false,false,POS_FACEUP)
end
