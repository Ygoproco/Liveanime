--Engrave Soul Light
function c511002724.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511002724.filter)
	--atk change other
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4857085,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511002724.chtg)
	e4:SetOperation(c511002724.chop)
	c:RegisterEffect(e4)
	--atk change equip
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511002724.descon)
	e5:SetOperation(c511002724.desop)
	c:RegisterEffect(e5)
	if not c511002724.global_check then
		c511002724.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002724.archchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002724.archchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,420)==0 then 
		Duel.CreateToken(tp,420)
		Duel.CreateToken(1-tp,420)
		Duel.RegisterFlagEffect(0,420,0,0,0)
	end
end
function c511002724.filter(c)
	return c420.IsRed(c) and c:IsType(TYPE_SYNCHRO)
end
function c511002724.atkfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c511002724.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002724.atkfilter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetEquipTarget():GetAttack()) end
end
function c511002724.chop(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetHandler():GetEquipTarget():GetAttack()
	local g=Duel.GetMatchingGroup(c511002724.atkfilter,tp,0,LOCATION_MZONE,nil,atk)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511002724.cfilter(c,tp)
	return c:GetPreviousControler()==1-tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002724.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002724.cfilter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1 and tc:GetBaseAttack()~=e:GetHandler():GetEquipTarget():GetAttack()
end
function c511002724.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002724.cfilter,nil,tp)
	local tc=g:GetFirst()
	local eq=e:GetHandler():GetEquipTarget()
	if eq then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(tc:GetBaseAttack())
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		eq:RegisterEffect(e2)
	end
end
