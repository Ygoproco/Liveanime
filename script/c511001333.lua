--Fusion Shot
function c511001333.initial_effect(c)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsType,TYPE_FUSION))
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001333,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c511001333.damcost)
	e2:SetTarget(c511001333.damtg)
	e2:SetOperation(c511001333.damop)
	c:RegisterEffect(e2)
end
function c511001333.cfilter(c,tp,eq)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and bit.band(c:GetReason(),0x40008)==0x40008 and c:GetReasonCard()==eq
		and c:IsAbleToRemoveAsCost() and c:IsAttackBelow(1000) and c:GetAttack()>0
end
function c511001333.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local eq=e:GetHandler():GetEquipTarget()
	local mg=eq:GetMaterial():Filter(c511001333.cfilter,nil,tp,eq)
	if chk==0 then return mg:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=mg:Select(tp,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetAttack())
end
function c511001333.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511001333.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
