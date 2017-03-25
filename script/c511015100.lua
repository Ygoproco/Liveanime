--Odd-Eyes Lancer Dragon
function c511015100.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511015100,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c511015100.spcon)
	e1:SetCost(c511015100.spcost)
	e1:SetTarget(c511015100.sptg)
	e1:SetOperation(c511015100.spop)
	c:RegisterEffect(e1)
	--negate effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015100,1))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c511015100.discost)
	e2:SetTarget(c511015100.distg)
	e2:SetOperation(c511015100.disop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--actlimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,1)
	e4:SetValue(c511015100.aclimit)
	e4:SetCondition(c511015100.actcon)
	c:RegisterEffect(e4)	
	--Damage to 0
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511015100,2))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511015100.dmcon)
	e5:SetCost(c511015100.dmcost)
	e5:SetTarget(c511015100.dmtarget)
	e5:SetOperation(c511015100.dmop)
	c:RegisterEffect(e5)
	--half damage
	local e6=e5:Clone()
	e6:SetDescription(aux.Stringid(511015100,3))
	e6:SetCondition(c511015100.dm2con)
	e6:SetCost(c511015100.dm2cost)
	e6:SetOperation(c511015100.dm2op)
	c:RegisterEffect(e6)
end
function c511015100.cfilter(c,tp)
	return c:IsPreviousSetCard(0x99) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511015100.costfilter(c)
	return not c:IsSetCard(0x99)
end
function c511015100.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511015100.cfilter,1,nil,tp)
end
function c511015100.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1 = Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x99)
	local b2 = Duel.CheckReleaseGroup(tp,c511015100.costfilter,2,nil)
	if chk==0 then return b1 or b2 end
	local b3 = true
	if b1 and b2 then b3 = Duel.SelectYesNo(tp,aux.Stringid(511015100,4)) end
	if b1 and b3 then
		local sg=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x99)
		Duel.Release(sg,REASON_COST)
	elseif b2 then
		local sg=Duel.SelectReleaseGroup(tp,c511015100.costfilter,2,2,nil)
		Duel.Release(sg,REASON_COST)
	end
end
function c511015100.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511015100.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end

function c511015100.discfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x99) and c:IsAbleToGraveAsCost()
end
function c511015100.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015100.discfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511015100.discfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511015100.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:GetControler()~=tp and aux.disfilter1(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.disfilter1,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,aux.disfilter1,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c511015100.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
	end
end

function c511015100.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511015100.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end

function c511015100.dmcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(tp) then e:SetLabelObject(a) else e:SetLabelObject(d) end
	return (a:IsControler(tp) or (d and d:IsControler(tp))) and Duel.GetFlagEffect(tp,511015100)==0
end
function c511015100.dmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHandAsCost() and c:IsSetCard(0x99)
end
function c511015100.dmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015100.dmfilter,tp,LOCATION_MZONE,0,1,e:GetLabelObject()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c511015100.dmfilter,tp,LOCATION_MZONE,0,1,1,e:GetLabelObject())
	Duel.SendtoHand(g,nil,REASON_COST)
	Duel.RegisterFlagEffect(tp,511015100,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511015100.dmtarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetCard(e:GetLabelObject())
end
function c511015100.dmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
	
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511015100.damop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c511015100.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end

function c511015100.dm2con(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(tp) then e:SetLabelObject(a) else e:SetLabelObject(d) end
	return (a:IsControler(tp) or (d and d:IsControler(tp))) and Duel.GetFlagEffect(tp,511015100+1)==0
end
function c511015100.dm2filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost() and c:IsSetCard(0x99)
end
function c511015100.dm2cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015100.dm2filter,tp,LOCATION_HAND,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511015100.dm2filter,tp,LOCATION_HAND,0,2,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
	Duel.RegisterFlagEffect(tp,511015100+1,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511015100.dm2op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
	end
	
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511015100.dam2op)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
end
function c511015100.dam2op(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp or ev==0 then return end
	Duel.ChangeBattleDamage(tp,ev/2)
	--damage opponent
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetTarget(c511015100.dmgtg)
	e1:SetOperation(c511015100.dmgop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511015100.dmgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511015100.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end