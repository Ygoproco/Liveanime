--Trick Buster
function c511015125.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511015125)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511015125.condition)
	e1:SetTarget(c511015125.target)
	e1:SetOperation(c511015125.desop)
	c:RegisterEffect(e1)
	
	local f=Duel.ChangeAttackTarget
	Duel.ChangeAttackTarget=function(c)
		f(c)
		if c:GetFlagEffect(511015125)==0 then
			Duel.RaiseEvent(c,511015125,e1,REASON_EFFECT,c:GetControler(),c:GetControler(),0)
			c:RegisterFlagEffect(511015125,RESET_CHAIN,0,0)
		end
	end
end
function c511015125.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511015125.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_MZONE):Select(tp,1,1,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511015125.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
