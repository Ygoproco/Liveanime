--Overlay Banish
--fixed by MLD
function c511005028.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DETACH_EVENT)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511005028.condition)
	e1:SetTarget(c511005028.target)
	e1:SetOperation(c511005028.activate)
	c:RegisterEffect(e1)
	if not c511005028.global_check then
		c511005028.global_check=true
		c511005028[0]=nil
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DETACH_MATERIAL)
		ge1:SetOperation(c511005028.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511005028.checkop(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetCurrentChain()
	if cid>0 then
		c511005028[0]=Duel.GetChainInfo(cid,CHAININFO_CHAIN_ID)
	end
end
function c511005028.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE 
		and Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)==c511005028[0] and Duel.IsChainDisablable(ev)
end
function c511005028.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511005028.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
