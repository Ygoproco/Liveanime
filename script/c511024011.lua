--Fossil Dyna Pachycephalo (Anime)
--Scripted by IanxWaifu
--fixed by MLD
function c511024011.initial_effect(c)
	--To Defense
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511024011.poscon)
	e1:SetTarget(c511024011.postg)
	e1:SetOperation(c511024011.posop)
	c:RegisterEffect(e1)
end
function c511024011.poscon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and not c:IsReason(REASON_BATTLE) and bc:IsReason(REASON_BATTLE) and c:IsRelateToBattle() 
		and bc:GetPreviousControler()~=tp
end
function c511024011.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	Duel.SetTargetParam(c:GetBattleTarget():GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c511024011.posop(e,tp,eg,ep,ev,re,r,rp)
	local def=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsPosition(POS_FACEUP_ATTACK) and c:IsRelateToEffect(e) and Duel.ChangePosition(c,POS_FACEUP_DEFENSE)>0 then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(def)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
	end
end
