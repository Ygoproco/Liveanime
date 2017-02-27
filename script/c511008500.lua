--Red Gazer
-- Trap Card Normal
function c511008500.initial_effect(c)
	-- [Effect e1] Make Effect Damage 0 and then Special Summon Token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511008500,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511008500.condition)
	e1:SetCost(c511008500.effcost)
	e1:SetOperation(c511008500.operation)
	c:RegisterEffect(e1)
end

------------- ############################ <Effect e1> ################################ -----


function c511008500.condition(e,tp,eg,ep,ev,re,r,rp)
	local e1=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DAMAGE)
	local e2=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
	local rd=e1 and not e2
	local rr=not e1 and e2
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then 
		return true 
	end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp==tp or cp==PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE)
end

function c511008500.effcost(e,tp,eg,ep,ev,re,r,rp,chk)
	-- Pay half of your LP
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end

function c511008500.operation (e,tp,eg,ep,ev,re,r,rp)
	local chainId=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	-- [1º SubEffect of E1: Apply the damage reduction, once the conditions (aux.damcon1) are true.]
	local e1NegateDamage=Effect.CreateEffect(e:GetHandler())
	e1NegateDamage:SetType(EFFECT_TYPE_FIELD)
	e1NegateDamage:SetCode(EFFECT_CHANGE_DAMAGE)
	e1NegateDamage:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1NegateDamage:SetTargetRange(1,0)
	e1NegateDamage:SetLabel(chainId)
	e1NegateDamage:SetValue(c511008500.valueOfdamage)
	e1NegateDamage:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1NegateDamage,tp)

	-- IF you do [e1NegateDamage] then  [2º SubEffect of E1: Special Summon 1 Red Token]}
	-- Is there 1 free zone for the token?
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	-- Can I make a special invocation of this particular token? 
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511008501,0x42f,TYPE_TOKEN+TYPE_NORMAL+TYPE_MONSTER,0,0,1,RACE_FIEND,ATTRIBUTE_FIRE) then return end
	-- Then, Special Summon my Awesome Token
	local token=Duel.CreateToken(tp,511008501)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	
end

------------- ################################ <SubEffect e1NegateDamage> ########################### -----

function c511008500.valueOfdamage (e,re,val,r,rp,rc)
	-- The number of the chain in which we are currently
	local cc=Duel.GetCurrentChain()
	-- If we are in the first chain or the reason is not due to an effect, it ends.
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end

	-- If the chained card is our card (chainId), return 0 (the damage received)
	local chainId=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if chainId==e:GetLabel() then return 0 end

	-- Otherwise, it returns the damage
	return val
end
------------- ################################ </SubEffect e1NegateDamage> ######################### -----
------------- ############################ </Effect e1> ################################ -----