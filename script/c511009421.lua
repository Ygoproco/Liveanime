--Dragon Creeping Plant
function c511009421.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009421.target)
	e1:SetOperation(c511009421.operation)
	c:RegisterEffect(e1)
	--destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511009421.descon2)
	e3:SetOperation(c511009421.desop2)
	c:RegisterEffect(e3)
end
function c511009421.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsControlerCanBeChanged() and not Duel.IsExistingMatchingCard(c34822850.lvlfilter,c:GetControler(),LOCATION_MZONE,0,1,nil,c:GetLevel())
end
function c34822850.lvlfilter(c,lv)
	return c:IsFaceup() and c:GetLevel()>lv
end
function c511009421.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511009421.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009421.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511009421.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511009421.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRace(RACE_DRAGON) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetCondition(c511009421.con)
		tc:RegisterEffect(e1)
	end
end
function c511009421.con(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end

function c511009421.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc) and tc:IsReason(REASON_DESTROY)
end
function c511009421.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end