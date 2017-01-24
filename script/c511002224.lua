--Goyo Arrow
function c511002224.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c511002224.filter)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c511002224.damtg)
	e4:SetOperation(c511002224.damop)
	c:RegisterEffect(e4)
end
function c511002224.filter(c)
	return c:IsSetCard(0x204) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(84305651) 
		or c:IsCode(58901502) or c:IsCode(59255742)
end
function c511002224.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetEquipTarget()
	if chk==0 then return ec and ec:GetLevel()>0 end
	local lv=ec:GetLevel()
	local dam=lv*100
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002224.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ec=e:GetHandler():GetEquipTarget()
	if not ec then return end
	local dam=ec:GetLevel()*100
	Duel.Damage(p,dam,REASON_EFFECT)
end
