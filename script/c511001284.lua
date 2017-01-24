--Phantom Fog Blade
function c511001284.initial_effect(c)
	aux.AddPersistentProcedure(c,1,c511001284.filter,CATEGORY_DISABLE,nil,nil,nil,nil,nil,c511001284.target,nil,true)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511001284.distg)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	c:RegisterEffect(e3)
end
function c511001284.distg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511001284.filter(c)
	return Duel.GetAttacker() and Duel.GetAttacker()==c
end
function c511001284.target(e,tp,eg,ep,ev,re,r,rp,tc)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,tc,1,0,0)
end
function c511001284.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsAttackable() then
		Duel.NegateAttack(tc)
	end
end
