--Dragon Creeping Plant
--fixed by MLD
function c511009421.initial_effect(c)
	aux.AddPersistentProcedure(c,1,c511009421.filter,CATEGORY_CONTROL,nil,nil,nil,c511009421.condition,nil,c511009421.target)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_CONTROL)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511009421.cttg)
	e1:SetValue(c511009421.ctval)
	c:RegisterEffect(e1)
	--destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511009421.descon)
	e3:SetOperation(c511009421.desop)
	c:RegisterEffect(e3)
end
function c511009421.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c511009421.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009421.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009421.filter(c)
	local g=Duel.GetFieldGroup(c:GetControler(),LOCATION_MZONE,0)
	if g:GetCount()<=0 then return false end
	local sg=g:GetMaxGroup(Card.GetLevel)
	if not sg then return false end
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsControlerCanBeChanged() 
		and (not sg:IsContains(c) or (c:IsType(TYPE_XYZ) and not c:IsHasEffect(EFFECT_RANK_LEVEL) and not c:IsHasEffect(EFFECT_RANK_LEVEL_S)))
end
function c511009421.target(e,tp,eg,ep,ev,re,r,rp,tc)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tc,1,0,0)
end
function c511009421.cttg(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c511009421.ctval(e,c)
	return e:GetHandlerPlayer()
end
function c511009421.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=c:GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511009421.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
