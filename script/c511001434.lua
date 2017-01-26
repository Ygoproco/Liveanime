--Rank Revolution
function c511001434.initial_effect(c)
	aux.AddPersistentProcedure(c,0,c511001434.filter,CATEGORY_DISABLE,nil,nil,0x1c0,c511001434.condition,nil,c511001434.target)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCondition(c511001434.discon)
	e1:SetTarget(c511001434.distg)
	e1:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511001434.bttg)
	e2:SetValue(c511001434.distg)
	c:RegisterEffect(e2)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511001434.descon)
	e2:SetOperation(c511001434.desop)
	c:RegisterEffect(e2)
end
function c511001434.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001434.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:IsFaceup() and tc:IsType(TYPE_XYZ)
end
function c511001434.discon(e)
	return e:GetHandler():GetFirstCardTarget()
end
function c511001434.distg(e,c)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and ((c:GetRank()>0 and c:GetRank()>tc:GetRank()) or (c:GetLevel()>0 and c:GetLevel()>tc:GetRank()))
end
function c511001434.bttg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511001434.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511001434.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
