--Speedroid Shuriken Hurricane
--fixed by MLD
function c511004403.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004403.target)
	c:RegisterEffect(e1)
	--damage reflect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511004403.con)
	e2:SetTarget(c511004403.tg)
	e2:SetOperation(c511004403.op)
	c:RegisterEffect(e2)
	--change damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(511001265)
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
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511004403.atkchk)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511004403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tev=Duel.GetCurrentChain()
	if tev>0 then
		if tev>1 and Duel.GetChainInfo(tev,CHAININFO_TRIGGERING_EFFECT)==e then
			tev=tev-1
		end
		local tep,trp,tre=Duel.GetChainInfo(tev,CHAININFO_TRIGGERING_CONTROLER,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_EFFECT)
		local teg=Group.FromCards(tre:GetOwner())
		if c511004403.con(e,tp,teg,tep,tev,tre,REASON_EFFECT,trp) and c511004403.tg(e,tp,teg,tep,tev,tre,REASON_EFFECT,trp,0) 
			and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
			e:SetOperation(c511004403.op2(tev))
			c511004403.tg(e,tp,teg,tep,tev,tre,REASON_EFFECT,trp,1)
		else
			e:SetOperation(nil)
		end
	end
end
function c511004403.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2016)
end
function c511004403.descon(e)
	return not Duel.IsExistingMatchingCard(c511004403.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511004403.con(e,tp,eg,ep,ev,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c511004403.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511004403)==0 end
	e:GetHandler():RegisterFlagEffect(511004403,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511004403.op2(tev)
	return function(e,tp,eg,ep,ev,re,r,rp)
				if not e:GetHandler():IsRelateToEffect(e) then return end
				local cid=Duel.GetChainInfo(tev,CHAININFO_CHAIN_ID)
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
end
function c511004403.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
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
function c511004403.cfilter(c)
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:GetAttack()~=val
end
function c511004403.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511004403.cfilter,1,nil)
end
function c511004403.diffilter1(c,g)
	local dif=0
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	if c:GetAttack()>val then dif=c:GetAttack()-val
	else dif=val-c:GetAttack() end
	return g:IsExists(c511004403.diffilter2,1,c,dif)
end
function c511004403.diffilter2(c,dif)
	local dif2=0
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	if c:GetAttack()>val then dif2=c:GetAttack()-val
	else dif2=val-c:GetAttack() end
	return dif~=dif2
end
function c511004403.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=eg:GetFirst()
	local g=eg:Filter(c511004403.diffilter1,nil,eg)
	local g2=Group.CreateGroup()
	if g:GetCount()>0 then g2=g:Select(tp,1,1,nil) ec=g2:GetFirst() end
	if g2:GetCount()>0 then Duel.HintSelection(g2) end
	local dam=0
	local val=0
	if ec:GetFlagEffect(284)>0 then val=ec:GetFlagEffectLabel(284) end
	if ec:GetAttack()>val then dam=ec:GetAttack()-val
	else dam=val-ec:GetAttack() end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511004403.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511004403.atkchk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,419)==0 and Duel.GetFlagEffect(1-tp,419)==0 then
		Duel.CreateToken(tp,419)
		Duel.CreateToken(1-tp,419)
		Duel.RegisterFlagEffect(tp,419,nil,0,1)
		Duel.RegisterFlagEffect(1-tp,419,nil,0,1)
	end
end
