--performapal nightmare knight
function c511004419.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c511004419.cost)
	e1:SetCondition(c511004419.condition)
	e1:SetTarget(c511004419.target)
	e1:SetOperation(c511004419.operation)
	c:RegisterEffect(e1)
	if not c511004419.global_check then
		c511004419.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511004419.gop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511004419.gop(e,tp,eg,ev,ep,re,r,rp)
	Duel.RegisterFlagEffect(1-rp,511004419,RESET_PHASE+PHASE_BATTLE,0,1)
end
function c511004419.cost(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),0,REASON_COST)
end
function c511004419.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<PHASE_MAIN2 and Duel.GetTurnPlayer()==tp
end
function c511004419.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,511004419)~=0 or Duel.GetFlagEffect(1-tp,511004419)~=0 end
	local dep=nil
	if Duel.GetFlagEffect(tp,511004419)~=0 and Duel.GetFlagEffect(1-tp,511004419)~=0 then
		dep=2
	elseif Duel.GetFlagEffect(tp,511004419)~=0 then
		dep=tp
	else
		dep=1-tp
	end
	Duel.SetTargetPlayer(dep)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,dep,1000)
end
function c511004419.operation(e,tp,eg,ev,ep,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if p~=2 then
		Duel.Damage(p,d,REASON_EFFECT)
	else
		Duel.Damage(1-tp,d,REASON_EFFECT)
		Duel.Damage(tp,d,REASON_EFFECT)
	end
end