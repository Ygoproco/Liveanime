--Dark Seed Planter
--fixed by MLD
function c511009396.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009396.target)
	e1:SetOperation(c511009396.activate)
	c:RegisterEffect(e1)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84013237,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511009396.atkcon)
	e1:SetOperation(c511009396.atkop)
	c:RegisterEffect(e1)
end

function c511009396.filter(c)
	return c:IsFaceup() and not c:IsAttribute(ATTRIBUTE_DARK)
end
function c511009396.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009396.filter,tp,LOCATION_MZONE,0,1,nil) end
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511009396.atkcon(e,tp,eg,ep,ev,re,r,rp) and Duel.SelectYesNo(tp,aux.Stringid(61965407,1)) then
		Duel.SetTargetParam(1)
	else
		Duel.SetTargetParam(0)
	end
end
function c511009396.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=Duel.GetMatchingGroup(c511009396.filter,tp,0,LOCATION_MZONE,nil)
	local tc=sg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(ATTRIBUTE_DARK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=sg:GetNext()
	end
	if Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)>0 then
		c511009396.atkop(e,tp,eg,ep,ev,re,r,rp)
	end
end
function c511009396.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a and d and a:IsFaceup() and d:IsFaceup() and a:IsControler(1-tp) and d:IsControler(tp) 
		and a:IsAttribute(ATTRIBUTE_DARK) and d:IsAttribute(ATTRIBUTE_DARK)
end
function c511009396.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateAttack()
end
