--Performance Exchange
--fixed by MLD
function c511004405.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004405.target)
	e1:SetOperation(c511004405.operation)
	c:RegisterEffect(e1)
end
function c511004405.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x9f) and Duel.IsExistingMatchingCard(c511004405.ctfilter,tp,LOCATION_MZONE,0,1,c,c:GetLevel())
end
function c511004405.ctfilter(c,lv)
	return c:IsFaceup() and c:GetLevel()>0 and c:GetLevel()<lv and c:IsControlerCanBeChanged()
end
function c511004405.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511004405.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511004405.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,c511004405.filter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	local g=Duel.GetMatchingGroup(c511004405.ctfilter,tp,LOCATION_MZONE,0,tc,tc:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c511004405.operation(e,tp,eg,ev,ep,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local lv=tc:GetLevel()
		local ctg=Duel.GetMatchingGroup(c511004405.ctfilter,tp,LOCATION_MZONE,0,nil,lv)
		local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
		local ct=math.min(ctg:GetCount(),ft)
		if ct>0 then
			if ctg:GetCount()>ct then
				ctg=ctg:Select(tp,ct,ct,nil)
			end
			Duel.GetControl(ctg,1-tp,RESET_PHASE+PHASE_END,1)
		end
	end
end
