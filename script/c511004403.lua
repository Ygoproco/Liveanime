--Speedroid Shuriken Hurricane
function c511004403.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage reflect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511004403.con)
	e2:SetOperation(c511004403.op)
	c:RegisterEffect(e2)
	--change damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(511004403)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511004403.damcon)
	e3:SetTarget(c511004403.damtg)
	e3:SetOperation(c511004403.damop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c511004403.descon)
	c:RegisterEffect(e4)
	if not c511004403.global_check then
		c511004403.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(c511004403.operation)
		Duel.RegisterEffect(ge1,0)
	end
end
--maintain effect
function c511004403.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2016) and c:IsType(TYPE_MONSTER)
end
function c511004403.descon(e)
	return not Duel.IsExistingMatchingCard(c511004403.filter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end
--reflect damage effect
function c511004403.con(e,tp,eg,ep,ev,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp) and rp~=tp
end
function c511004403.op(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511004403.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511004403.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cid==e:GetLabel()
end
--damage change effect
function c511004403.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	e:SetLabel(ev)
	return eg:GetCount()==1 and ec:IsControler(1-tp) and ev>0
end
function c511004403.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511004403.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
--global effect
function c511004403.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler() 
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511004403)==0 then
			local e1=Effect.CreateEffect(c) 
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_ADJUST)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511004403.gop)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511004403,RESET_EVENT+0x1fe0000,0,1)  
		end 
		tc=g:GetNext()
	end
end
function c511004403.gop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if e:GetLabel()>c:GetAttack() then
		val=e:GetLabel()-c:GetAttack()
	else
		val=c:GetAttack()-e:GetLabel()
	end
	Duel.RaiseEvent(c,511004403,e,0,0,tp,val)
	e:SetLabel(c:GetAttack())
end