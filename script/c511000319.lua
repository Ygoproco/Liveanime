--Dress Up
function c511000319.initial_effect(c)
	aux.AddEquipProcedure(c)
	--pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000319,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511000319.postg)
	e3:SetOperation(c511000319.posop)
	c:RegisterEffect(e3)
	--Atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(300)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetCondition(c511000319.atkcon)
	e5:SetTarget(c511000319.atktg)
	e5:SetValue(c511000319.atkval)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e6:SetCondition(c511000319.atkcon)
	c:RegisterEffect(e6)
end
function c511000319.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000319.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
function c511000319.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandler():GetControler(),0,LOCATION_MZONE,1,nil)
end
function c511000319.atkfilter(c,atk)
	return c:IsFaceup() and c:IsPosition(POS_FACEUP_ATTACK) and c:GetAttack()<atk
end
function c511000319.atktg(e,c)
	if c:IsPosition(POS_FACEUP_ATTACK) then
		return Duel.IsExistingMatchingCard(c511000319.atkfilter,c:GetControler(),LOCATION_MZONE,0,1,c,c:GetAttack())
	else return true end
end
function c511000319.atkval(e,c)
	return c==e:GetHandler():GetEquipTarget()
end
