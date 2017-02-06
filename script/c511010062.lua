--Number 62: Galaxy-Eyes Prime Photon Dragon (Anime)
--No.62 銀河眼の光子竜皇 (Anime)
--Scripted By TheOnePharaoh
--fixed by MLD
function c511010062.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010062.atkcon)
	e1:SetValue(c511010062.atkval)
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
	e3:SetTarget(function(e,c) return not c:IsType(TYPE_XYZ) end)
	c:RegisterEffect(e3)
	-- Update Rank Rank/Level
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1)
	e4:SetTarget(c511010062.rktg)
	e4:SetOperation(c511010062.rkop)
	c:RegisterEffect(e4)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511010062.indes)
	c:RegisterEffect(e5)
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
function c511010062.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and e:GetHandler():GetBattleTarget()
end
function c511010062.atkval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	return g:GetSum(Card.GetRank)*200
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
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		--atk
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(511010062,0))
		e1:SetCategory(CATEGORY_ATKCHANGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EVENT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetLabel(e:GetLabel())
		e1:SetOperation(c511010062.atkop2)
		c:RegisterEffect(e1)
	end
end
function c511010062.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cr=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetAttack()*e:GetLabel())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511010062.rktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511010062.rkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_RANK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c511010062.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,31801517)
	Duel.CreateToken(1-tp,31801517)
end
function c511010062.indes(e,c)
	return not c:IsSetCard(0x48)
end
