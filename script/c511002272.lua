-- Saber of Malice
function c511002272.initial_effect(c)
	aux.AddEquipProcedure(c)
	-- destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002272.descon)
	e2:SetTarget(c511002272.destg)
	e2:SetOperation(c511002272.desop)
	c:RegisterEffect(e2)
end
function c511002272.descon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	local d=Duel.GetAttackTarget()
	return ec==Duel.GetAttacker() and d and d:IsDefensePos() and ec:IsRace(0x10000000)
end
function c511002272.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttackTarget(),1,0,0)
end
function c511002272.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if tc and tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
