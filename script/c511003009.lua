--究極恐獣
function c511003009.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FIRST_ATTACK)
	e1:SetCondition(c511003009.facon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetCondition(c511003009.facon)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetCondition(c511003009.facon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c511003009.regop)
	c:RegisterEffect(e4)
	if not c511003009.global_check then
		c511003009.global_check=true
		c511003009[0]=0
		c511003009[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c511003009.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
		ge2:SetOperation(c511003009.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511003009.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if c511003009[tc:GetControler()]==0 then
		c511003009[tc:GetControler()]=1
		tc:RegisterFlagEffect(15894048,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	elseif tc:GetFlagEffect(15894048)==0 then
		c511003009[tc:GetControler()]=2
	end
end
function c511003009.clear(e,tp,eg,ep,ev,re,r,rp)
	c511003009[0]=0
	c511003009[1]=0
end
function c511003009.facon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and e:GetHandler():GetFlagEffect(511003009)>0
		and c511003009[tp]==e:GetHandler():GetFlagEffect(15894048)
end
function c511003009.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511003009,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
