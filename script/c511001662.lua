--Number Lockdown
function c511001662.initial_effect(c)
	aux.AddPersistentProcedure(c,nil,c511001662.filter,CATEGORY_DISABLE,nil,nil,0x1c0,nil,nil,c511001662.target)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.PersistentTargetFilter)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	c:RegisterEffect(e2)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(123709,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCondition(c511001662.descon)
	e2:SetTarget(c511001662.destg)
	e2:SetOperation(c511001662.desop)
	c:RegisterEffect(e2)
end
function c511001662.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end
function c511001662.target(e,tp,eg,ep,ev,re,r,rp,tc)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,tc,1,0,0)
end
function c511001662.descon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c511001662.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if chk==0 then return tc end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Group.FromCards(c,tc),2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack())
end
function c511001662.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	local atk=tc:GetAttack()
	if Duel.Destroy(Group.FromCards(c,tc),REASON_EFFECT)>1 then
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
