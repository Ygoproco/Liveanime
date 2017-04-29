--Pendulum Transfer
function c511015126.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015126,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015126.pentg)
	e1:SetOperation(c511015126.penop)
	c:RegisterEffect(e1)
end
function c511015126.filter(c)
	return true--c:IsFaceup() --and c:IsType(TYPE_PENDULUM)
end
function c511015126.pentg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511015126.filter(chkc) end
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) and Duel.CheckLocation(tp,LOCATION_SZONE,7)
		and Duel.IsExistingTarget(c511015126.filter,tp,LOCATION_MZONE,0,2,nil) end
end
function c511015126.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) or not Duel.CheckLocation(tp,LOCATION_SZONE,7)
		or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local tg=Duel.SelectMatchingCard(tp,c511015126.filter,tp,LOCATION_MZONE,0,2,2,nil)
	local tc1=tg:GetFirst()
	local tc2=tg:GetNext()
	if tc1:GetLevel()>tc2:GetLevel() then tc1,tc2=tc2,tc1 end
	
	if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 then
		Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
	end
	Duel.MoveToField(tc2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveSequence(tc2,6)
	Duel.MoveToField(tc1,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.MoveSequence(tc1,7)
	
	aux.EnablePendulumAttribute(tc1)
	aux.EnablePendulumAttribute(tc2)
	
	--set scales
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(tc1:GetLevel()+tc2:GetLevel()+1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc1:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	tc1:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetValue(tc2:GetLevel()-tc1:GetLevel())
	tc2:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_RSCALE)
	tc2:RegisterEffect(e4)
end
