--Delay Armor
function c511009168.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0xc008))
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75886890,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009168.eqcon)
	e2:SetCost(c511009168.eqcost)
	e2:SetTarget(c511009168.eqtg)
	e2:SetOperation(c511009168.eqop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12174035,0))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c511009168.descon)
	e3:SetTarget(c511009168.destg)
	e3:SetOperation(c511009168.desop)
	c:RegisterEffect(e3)	
end
function c511009168.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()
end
function c511009168.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabelObject(e:GetHandler():GetEquipTarget())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511009168.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
end
function c511009168.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end
function c511009168.descon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	if not bc then return false end
	e:SetLabel(bc:GetLevel())
	return e:GetHandler():GetEquipTarget()==ec and bc:GetPreviousControler()==1-tp and bc:IsReason(REASON_BATTLE)
end
function c511009168.desfilter(c,lv)
	return c:IsFaceup() and c:IsLevelBelow(lv)
end
function c511009168.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=e:GetLabel()
	if chk==0 then return Duel.IsExistingMatchingCard(c511009168.desfilter,tp,0,LOCATION_MZONE,1,nil,lv) end
	local g=Duel.GetMatchingGroup(c511009168.desfilter,tp,0,LOCATION_MZONE,nil,lv)
	Duel.SetTargetParam(lv)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511009168.desop(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511009168.desfilter,tp,0,LOCATION_MZONE,1,1,nil,lv)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.Damage(1-tp,500,REASON_EFFECT)
end

