--ギミック・シールド
function c111012401.initial_effect(c)
	aux.AddEquipProcedure(c,nil,c111012401.filter)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SWAP_BASE_AD)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c111012401.damtg)
	e4:SetOperation(c111012401.damop)
	c:RegisterEffect(e4)	
end
function c111012401.filter(c)
	return c:IsSetCard(0x83) and c:IsType(TYPE_XYZ)
end
function c111012401.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetEquipTarget()
	if chk==0 then return ec and ec:GetOverlayCount()>0 end
	local dam=ec:GetOverlayCount()*300
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c111012401.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetEquipTarget()
	if not c:IsRelateToEffect(e) or not ec then return end
	local dam=ec:GetOverlayCount()*300
	Duel.Damage(1-tp,dam,REASON_EFFECT)
end
