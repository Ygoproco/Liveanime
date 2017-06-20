--Dark Contract with Underworld Insurance
--cleaned up by MLD
function c511018011.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511018011.condition)
	e1:SetTarget(c511018011.target)
	e1:SetOperation(c511018011.operation)
	c:RegisterEffect(e1)
	if not c511018011.global_check then
		c511018011.global_check=true
		c511018011[0]=Group.CreateGroup()
		c511018011[1]=Group.CreateGroup()
		c511018011[0]:KeepAlive()
		c511018011[1]:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511018011.chkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511018011.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511018011.chkop(e,tp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	if a:IsControler(tp) and d:IsRelateToBattle() and d:IsLocation(LOCATION_MZONE) then
		c511018011[tp]:AddCard(d)
	elseif a:IsControler(1-tp) and d:IsRelateToBattle() and d:IsLocation(LOCATION_MZONE) then
		c511018011[1-tp]:AddCard(d)
	end
end
function c511018011.clearop()
	c511018011[0]:Clear()
	c511018011[1]:Clear()
end
function c511018011.condition(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2 and Duel.GetTurnPlayer()==tp
end
function c511018011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=c511018011[tp]
	local ct=g:GetCount()
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511018011.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
