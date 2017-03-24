--Performance Dragon's Shadow
function c511004430.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511004430.condition)
	e1:SetTarget(c511004430.target)
	e1:SetOperation(c511004430.operation)
	c:RegisterEffect(e1)
end
function c511004430.conditionfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsControler(1-tp)
end
function c511004430.condition(e,tp,eg,ev,ep,re,r,rp)
	return eg:IsExists(c511004430.conditionfilter,1,nil,tp)
end
function c511004430.filter1(c,tp,mc)
	if mc then
		return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0x9f) and c~=mc
	end
	return c:IsType(TYPE_MONSTER) and c:IsReleasable() and Duel.IsExistingTarget(c511004430.filter1,tp,LOCATION_MZONE,0,1,nil,tp,c)
end
function c511004430.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004430.filter1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tg=Duel.SelectMatchingCard(tp,c511004430.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	Duel.SelectTarget(tp,c511004430.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp,tg)
	Duel.Release(tg,REASON_EFFECT)
end
function c511004430.filter2(c,mc)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and not (c:IsForbidden() or c==mc)
end
function c511004430.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE)
	e1:SetValue(1)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	if Duel.IsExistingMatchingCard(c511004430.filter2,tp,LOCATION_MZONE,0,1,nil,tc) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local ec=Duel.SelectMatchingCard(tp,c511004430.filter2,tp,LOCATION_MZONE,0,1,1,nil,tc):GetFirst()
		if not Duel.Equip(tp,ec,tc,false) then return end
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511004430.eqlimit)
		e1:SetLabelObject(tc)
		ec:RegisterEffect(e1)
		--attack
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(ec:GetAttack())
		ec:RegisterEffect(e2)
		--spsummon
		local e3=Effect.CreateEffect(c)
		e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetRange(LOCATION_SZONE)
		e3:SetLabelObject(tc)
		e3:SetCountLimit(1)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetCondition(c511004430.spcondition)
		e3:SetOperation(c511004430.spoperation)
		ec:RegisterEffect(e3)
	end
end
function c511004430.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511004430.spcondition(e,tp,eg,ev,ep,re,r,rp)
	return e:GetLabelObject():GetEquipGroup():IsContains(e:GetHandler())
end
function c511004430.spoperation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)==0 and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
		Duel.SendtoGrave(c,REASON_RULE)
	end 
end