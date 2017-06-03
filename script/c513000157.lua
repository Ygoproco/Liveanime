--Speed Spell - Tyrant Force (Anime)
--scripted by Larry126
function c513000157.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000157.con)
	e1:SetOperation(c513000157.activate)
	c:RegisterEffect(e1)
end
function c513000157.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>9
end
function c513000157.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	Duel.RegisterEffect(e2,tp)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c513000157.damcon)
	e3:SetOperation(c513000157.damop)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c513000157.cfilter(c,tp)
	return c:GetPreviousControler()==1-tp
end
function c513000157.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c513000157.cfilter,1,nil,tp)
end
function c513000157.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c513000157.cfilter,nil,tp)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end