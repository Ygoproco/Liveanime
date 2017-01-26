--No.34 電算機獣テラ・バイト (Anime)
function c511010034.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,3)
	c:EnableReviveLimit()
	--control
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetDescription(aux.Stringid(32003338,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG2_XMDETACH+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010034.cost)
	e1:SetTarget(c511010034.target)
	e1:SetOperation(c511010034.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010034.indes)
	c:RegisterEffect(e2)
	if not c511010034.global_check then
		c511010034.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511010034.numchk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511010034.xyz_number=34
function c511010034.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010034.filter(c)
	return c:IsFaceup() and c:IsAttackPos() and c:IsLevelBelow(4) and c:IsControlerCanBeChanged()
end
function c511010034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511010034.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511010034.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511010034.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511010034.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
function c511010034.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,32003338)
	Duel.CreateToken(1-tp,32003338)
end
function c511010034.indes(e,c)
	return not c:IsSetCard(0x48)
end