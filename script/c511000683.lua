--Number Frame
function c511000683.initial_effect(c)
	aux.AddEquipProcedure(c,0,aux.FilterBoolFunction(Card.IsSetCard,0x7f),nil,nil,nil,c511000683.op)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1500)
	c:RegisterEffect(e2)
end
function c511000683.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_EXTRA,0,nil,0x48)
		if g:GetCount()>=2 and Duel.SelectYesNo(tp,aux.Stringid(511000683,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local og=g:Select(tp,2,2,nil)
			Duel.Overlay(tc,og)
		end
	end
end
