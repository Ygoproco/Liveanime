--Lost Wind (Anime)
function c511247005.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511247005.target)
	e1:SetOperation(c511247005.activate)
	c:RegisterEffect(e1)
end
function c511247005.filter(c,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsCanBeEffectTarget()
end
function c511247005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511247005.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
	local g=eg:Filter(c511247005.filter,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,g:GetCount(),0,0)
end
function c511247005.filter2(c,e,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsRelateToEffect(e)
end
function c511247005.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511247005.filter2,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	Duel.NegateRelatedChain(tc,RESET_TURN_SET)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	tc:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetValue(tc:GetBaseAttack()/2)
	tc:RegisterEffect(e3)
end