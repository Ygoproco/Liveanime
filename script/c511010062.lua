--Number 62: Galaxy-Eyes Prime Photon Dragon (Anime)
--No.62 銀河眼の光子竜皇 (Anime)
--Scripted By TheOnePharaoh
function c511010062.initial_effect(c)
--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010062,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010062.atkcon)
	e1:SetCost(c511010062.atkcost)
	e1:SetOperation(c511010062.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511010062,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511010062.spcon)
	e2:SetOperation(c511010062.spop)
	c:RegisterEffect(e2)
	-- Level/Rank
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCode(EFFECT_LEVEL_RANK_S)
	e3:SetTarget(function (e,c) return not c:IsType(TYPE_XYZ)end)
	c:RegisterEffect(e3)
	-- Update Rank Rank/Level
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetTarget(c511010062.target)
	e4:SetOperation(c511010062.op)
	c:RegisterEffect(e4)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511010062.indes)
	c:RegisterEffect(e5)
	--resetlevel
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetOperation(c511010062.evop)
	c:RegisterEffect(e7)
	if not c511010062.global_check then
		c511010062.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010062.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010062.xyz_number=62
function c511010062.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end
function c511010062.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(511010062)==0 end
	c:RegisterFlagEffect(511010062,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511010062.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	 	local val=math.ceil(g:GetSum(Card.GetRank))*200
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(val)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
	end
end
function c511010062.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	e:SetLabel(c:GetOverlayCount())
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetOverlayCount()>0
end
function c511010062.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cr=e:GetLabel()
	local cr1=cr+1
	local cr2=cr+2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_EXTRA+LOCATION_REMOVED+LOCATION_GRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	if Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,cr2)
	else
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,cr1)
	end
	e1:SetCountLimit(1)
	e1:SetLabel(cr)
	e1:SetCondition(c511010062.spcon2)
	e1:SetOperation(c511010062.spop2)
	Duel.RegisterEffect(e1,tp)
	c:SetTurnCounter(0)
end
function c511010062.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511010062.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	local cr=e:GetLabel()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==cr then
		Duel.SpecialSummonStep(c,SUMMON_TYPE_SPECIAL,tp,tp,true,false,POS_FACEUP)
			--atk
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(511010062,0))
			e1:SetCategory(CATEGORY_ATKCHANGE)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
			e1:SetCode(EVENT_ATTACK_ANNOUNCE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			e1:SetLabel(e:GetLabel())
			e1:SetCondition(c511010062.atkcon2)
			e1:SetCost(c511010062.atkcost2)
			e1:SetOperation(c511010062.atkop2)
			c:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
function c511010062.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker()
end
function c511010062.atkcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(511010062)==0 end
	c:RegisterFlagEffect(511010062,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511010062.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cr=e:GetLabel()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE+EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetAttack()*e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c511010062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511010062.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_RANK)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	tc:RegisterEffect(e1)
	tc=g:GetNext()
	end
end
function c511010062.evop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(e:GetHandler(),511010062,re,REASON_EFFECT,rp,tp,1)
end
function c511010062.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,31801517)
	Duel.CreateToken(1-tp,31801517)
end
function c511010062.indes(e,c)
return not c:IsSetCard(0x48)
end
