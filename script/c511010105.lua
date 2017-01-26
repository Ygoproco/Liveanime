--Number 105: Battlin' Boxer Star Cestus (Anime)
--No.105 BK 流星のセスタス (Anime)
function c511010105.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59627393,0))
	e1:SetProperty(EFFECT_FLAG2_XMDETACH)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetCondition(c511010105.condition)
	e1:SetCost(c511010105.cost)
	e1:SetOperation(c511010105.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010105.indes)
	c:RegisterEffect(e3)
	if not c511010105.global_check then
		c511010105.global_check=true
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511010105.numchk)
		Duel.RegisterEffect(ge3,0)
	end
c511010105.xyz_number=105
function c511010105.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if at:IsControler(tp) then return false end
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and a and at and 
	(a:IsControler(tp) and a:IsOnField() and a==e:GetHandler() and at:IsControler(1-tp) and at:IsOnField() and at:GetAttack()>a:GetAttack())
end
function c511010105.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,511010105)==0 and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.RegisterFlagEffect(tp,511010105,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c511010105.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if a:IsFacedown() or at:IsControler(tp) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	a:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e2:SetValue(1)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	a:RegisterEffect(e2,true)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UNSTOPPABLE_ATTACK)
	e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
	a:RegisterEffect(e3,true)
end
function c511010105.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,59627393)
	Duel.CreateToken(1-tp,59627393)
end
function c511010105.indes(e,c)
	return not c:IsSetCard(0x48)
end