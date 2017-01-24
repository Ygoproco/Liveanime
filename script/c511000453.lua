--Crystal Seal
function c511000453.initial_effect(c)
	aux.AddPersistentProcedure(c,1,aux.FilterBoolFunction(Card.IsFaceup),CATEGORY_POSITION+CATEGORY_DISABLE,nil,nil,0x1c0,nil,nil,c511000453.target)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511000453.distg)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e5)
	local e6=e1:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	c:RegisterEffect(e6)
	local e7=e1:Clone()
	e7:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	c:RegisterEffect(e7)
	--Destroy
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(511001762)
	e8:SetCondition(c511000453.descon)
	e8:SetOperation(c511000453.desop)
	c:RegisterEffect(e8)
	--indestructable
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_SZONE)
	e9:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e9:SetValue(c511000453.indval)
	c:RegisterEffect(e9)
	if not c511000453.global_check then
		c511000453.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000453.atkchk)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000453.atkchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,419)==0 and Duel.GetFlagEffect(1-tp,419)==0 then
		Duel.CreateToken(tp,419)
		Duel.CreateToken(1-tp,419)
		Duel.RegisterFlagEffect(tp,419,nil,0,1)
		Duel.RegisterFlagEffect(1-tp,419,nil,0,1)
	end
end
function c511000453.target(e,tp,eg,ep,ev,re,r,rp,tc)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,tc,1,0,0)
end
function c511000453.distg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511000453.efilter(e,re,rp)
	return e:GetHandlerPlayer()~=rp
end
function c511000453.cfilter(e,c)
	return c==e:GetHandler()
end
function c511000453.rcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
function c511000453.cfilter(c,ec)
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:IsFaceup() and ec:IsHasCardTarget(c) and c:GetAttack()~=val
end
function c511000453.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000453.cfilter,1,nil,e:GetHandler())
end
function c511000453.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511000453.indval(e,re,tp)
	return e:GetOwner()~=re:GetOwner()
end
