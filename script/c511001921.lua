--Golden Rule
function c511001921.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x1034),nil,nil,nil,c511001921.op)
	--Destroy (S/T)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511001921.descon1)
	e3:SetOperation(c511001921.desop1)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c511001921.desop2)
	c:RegisterEffect(e4)
end
function c511001921.stfilter(c)
	return c:IsLevelBelow(3) and c:IsSetCard(0x1034)
end
function c511001921.spfilter(c,e,tp)
	return c:IsSetCard(0x1034) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001921.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local stg=Duel.GetMatchingGroup(c511001921.stfilter,tp,LOCATION_DECK,0,nil)
		if Duel.GetLocationCount(tp,LOCATION_SZONE)>1 and stg:GetCount()>1 
			and Duel.SelectYesNo(tp,aux.Stringid(10004783,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
			local sg1=stg:Select(tp,2,2,nil)
			local tc1=sg1:GetFirst()
			while tc1 do
				Duel.MoveToField(tc1,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				local e1=Effect.CreateEffect(tc)
				e1:SetCode(EFFECT_CHANGE_TYPE)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetReset(RESET_EVENT+0x1fc0000)
				e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
				tc1:RegisterEffect(e1)
				tc1=sg1:GetNext()
			end
			Duel.RaiseEvent(sg1,47408488,e,0,tp,0,0)
			local spg=Duel.GetMatchingGroup(c511001921.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
			if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and spg:GetCount()>0 
				and Duel.SelectYesNo(tp,aux.Stringid(70245411,2)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local sp=spg:Select(tp,1,1,nil)
				Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
				sg1:Merge(sp)
			end
			local gtc=sg1:GetFirst()
			while gtc do
				c:SetCardTarget(gtc)
				gtc=sg1:GetNext()
			end
		end
	end
end
function c511001921.desfilter1(c,eg)
	return c:GetPreviousLocation()==LOCATION_SZONE and eg:IsContains(c)
end
function c511001921.descon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local g=c:GetCardTarget()
	return g:GetCount()>0 and g:IsExists(c511001921.desfilter1,1,e:GetHandler():GetEquipTarget(),eg)
end
function c511001921.desop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT)
end
function c511001921.desop2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	if g:GetCount()<=0 then return end
	local tc=g:Filter(Card.IsLocation,e:GetHandler():GetEquipTarget(),LOCATION_MZONE):GetFirst()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
