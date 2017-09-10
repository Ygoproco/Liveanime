--Decoy Baby
--scripted by andré
--fixed by MLD
function c511004339.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004339.target)
	e1:SetOperation(c511004339.activate)
	c:RegisterEffect(e1)
end
function c511004339.filter1(c,tp)
	return c:IsFaceup() and c:GetCounter(0x1107)~=0 and Duel.IsExistingMatchingCard(c511004339.filter2,tp,0,LOCATION_MZONE,1,nil,c:GetRace())
end
function c511004339.filter2(c,rc)
	return c:IsFaceup() and c:IsRace(rc)
end
function c511004339.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511004339.filter1(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511004339.filter1,tp,LOCATION_SZONE,0,1,nil,tp) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511004339.filter1,tp,LOCATION_SZONE,0,1,1,nil)
end
function c511004339.activate(e,tp,eg,ev,ep,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.SelectMatchingCard(tp,c511004339.filter2,tp,0,LOCATION_MZONE,1,1,nil,tc:GetRace())
		local tc2=g:GetFirst()
		if tc2 then
			Duel.HintSelection(g)
			Duel.MoveToField(tc2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			tc2:AddCounter(0x1107,1)
		end
	end
end
