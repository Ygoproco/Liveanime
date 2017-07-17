--Performapal Bubblewowow (Anime)
--AlphaKretin
--fixed by MLD
function c511310012.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy replace (pzone)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c511310012.reptg)
	e2:SetValue(c511310012.repval)
	e2:SetOperation(c511310012.repop)
	c:RegisterEffect(e2)
	--destroy replace (mzone)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511310012.reptg2)
	e3:SetValue(c511310012.repval2)
	e3:SetOperation(c511310012.repop2)
	c:RegisterEffect(e3)
end
function c511310012.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and not c:IsType(TYPE_PENDULUM) and c:GetSummonLocation()==LOCATION_EXTRA
		and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c511310012.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511310012.filter,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(34379489,0))
end
function c511310012.repval(e,c)
	return c511310012.filter(c,e:GetHandlerPlayer())
end
function c511310012.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
function c511310012.filter2(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_PZONE) and not c:IsReason(REASON_REPLACE)
end
function c511310012.reptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511310012.filter2,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED) end
	return Duel.SelectYesNo(tp,aux.Stringid(34379489,0))
end
function c511310012.repval2(e,c)
	return c511310012.filter2(c,e:GetHandlerPlayer())
end
function c511310012.repop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT+REASON_REPLACE)
end
