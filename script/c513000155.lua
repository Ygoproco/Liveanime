--Speed Spell - Speed Force (Anime)
--Ｓｐ－スピード・フォース
--scripted by Larry126
function c513000155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000155.con)
	e1:SetOperation(c513000155.activate)
	c:RegisterEffect(e1)
end
function c513000155.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>3
end
function c513000155.activate(e,tp,eg,ep,ev,re,r,rp)
	--indestructable
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetValue(c513000155.indval)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	Duel.RegisterEffect(e1,tp)
end
function c513000155.indval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and re:GetOwner()~=e:GetOwner()
end