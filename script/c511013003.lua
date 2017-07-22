--Gagaga Magician
--fixed by MLD
function c511013003.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511013003,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511013003.op)
	c:RegisterEffect(e1)
end
function c511013003.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local t={}
		local i=1
		local p=1
		local lv=c:GetLevel()
		for i=1,8 do 
			if lv~=i then t[p]=i p=p+1 end
		end
		t[p]=nil
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511013003,1))
		local lv2=Duel.AnnounceNumber(tp,table.unpack(t))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv2)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
