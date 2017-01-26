--Forest Burst
function c511002204.initial_effect(c)
	aux.AddEquipProcedure(c)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511002204.descon)
	e2:SetTarget(c511002204.destg)
	e2:SetOperation(c511002204.desop)
	c:RegisterEffect(e2)
end
function c511002204.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and c:GetFirstCardTarget() 
		and c:GetFirstCardTarget():IsLocation(LOCATION_MZONE)
end
function c511002204.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetPreviousEquipTarget()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c511002204.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
