--Gagaga Caesar
--fixed by MLD
function c511013027.initial_effect(c)
	--level change
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetDescription(aux.Stringid(9583383,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c511013027.lvtg)
	e3:SetOperation(c511013027.lvop)
	c:RegisterEffect(e3)
end
function c511013027.filter(c,lv)
	return c:IsFaceup() and c:GetLevel()>0 and c:GetLevel()~=lv
end
function c511013027.rfilter(c,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c511013027.filter,tp,LOCATION_MZONE,0,1,nil,lv)
end
function c511013027.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511013027.rfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511013027.rfilter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511013027.rfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511013027.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		local lv=tc:GetLevel()
		local g=Duel.GetMatchingGroup(c511013027.filter,tp,LOCATION_MZONE,0,nil,lv)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end
