--Over Boost
function c110000106.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,0x10000000))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c110000106.regcon)
	e2:SetOperation(c110000106.regop)
	c:RegisterEffect(e2)
	if not c110000106.global_check then
		c110000106.global_check=true
		if Duel.GetFlagEffect(0,110000104)==0 and Duel.GetFlagEffect(1,110000104)==0 then
			Duel.RegisterFlagEffect(0,110000104,0,0,1)
			Duel.RegisterFlagEffect(1,110000104,0,0,1)
			--cannot attack
			local ge1=Effect.CreateEffect(c)
			ge1:SetType(EFFECT_TYPE_FIELD)
			ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			ge1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			ge1:SetCondition(c110000106.atkcon)
			ge1:SetTarget(c110000106.atktg)
			Duel.RegisterEffect(ge1,0)
			--check
			local ge2=Effect.CreateEffect(c)
			ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			ge2:SetCode(EVENT_ATTACK_ANNOUNCE)
			ge2:SetOperation(c110000106.checkop)
			ge2:SetLabelObject(ge1)
			Duel.RegisterEffect(ge2,0)
			--change attack target
			local ge3=Effect.CreateEffect(c)
			ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge3:SetCode(EVENT_BE_BATTLE_TARGET)
			ge3:SetCondition(c110000106.atcon)
			ge3:SetOperation(c110000106.atop)
			Duel.RegisterEffect(ge3,0)
			local ge4=ge3:Clone()
			Duel.RegisterEffect(ge4,1)
		end
	end
end
function c110000106.atkcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),110000103)~=0 and Duel.GetFlagEffect(1-e:GetHandlerPlayer(),110000103)~=0
end
function c110000106.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(0x10000000)
end
function c110000106.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsType(0x10000000) then return end
	if Duel.GetFlagEffect(tp,110000103)~=0 and Duel.GetFlagEffect(1-tp,110000103)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	Duel.RegisterFlagEffect(tp,110000103,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(1-tp,110000103,RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c110000106.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsType(0x10000000)
end
function c110000106.filter(c)
	return c:IsFaceup() and c:IsType(0x10000000)
end
function c110000106.atop(e,tp,eg,ep,ev,re,r,rp)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local d=Duel.GetAttackTarget()
	if atg:IsExists(c110000106.filter,1,d) and Duel.SelectYesNo(tp,aux.Stringid(21558682,0)) then
		local g=atg:FilterSelect(tp,c110000106.filter,1,1,d)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c110000106.regcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return not Duel.GetAttackTarget() and a:IsType(0x10000000) and a:IsControler(tp) and a:GetEffectCount(EFFECT_DIRECT_ATTACK)==1 
		and e:GetHandler():GetFlagEffect(110000106)==0
		and Duel.IsExistingMatchingCard(aux.NOT(Card.IsHasEffect),tp,0,LOCATION_MZONE,1,nil,EFFECT_IGNORE_BATTLE_TARGET)
end
function c110000106.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(110000106,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabelObject(c)
	e1:SetCondition(c110000106.descon)
	e1:SetOperation(c110000106.desop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c110000106.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(110000106)>0 then
		return true
	else
		e:Reset()
		return false
	end
end
function c110000106.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,110000106)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end
