--Fossil Dyna Pachycephalo (Anime)
--Scripted by IanxWaifu
function c511024011.initial_effect(c)
	--To Defense
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.bdocon)
	e1:SetOperation(c511024011.posop)
	c:RegisterEffect(e1)
end
function c511024011.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetHandler():GetBattleTarget()
	local def=tc:GetDefense()
	if c:IsAttackPos() then
		if Duel.ChangePosition(c,POS_FACEUP_DEFENCE)~=0 and tc:GetBaseDefense()>=0 
		and c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
			e1:SetValue(def)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
			c:RegisterEffect(e1)
		end
	end
end