--Cubic Wave (movie)
function c511004444.initial_effect(c)
	--remain field
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e0)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004444.target)
	e1:SetOperation(c511004444.operation)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511004444.atktg1)
	e2:SetValue(c511004444.atkval1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511004444.atktg2)
	e3:SetValue(c511004444.atkval2)
	c:RegisterEffect(e3)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
	e2:SetLabelObject(g)
	e3:SetLabelObject(g)
end
function c511004444.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsSetCard(0xe3)
end
function c511004444.target(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004444.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELF)
	local tg=Duel.SelectTarget(tp,c511004444.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local g=e:GetLabelObject()
	g:AddCard(tg:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local tge=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	tg:Merge(tge)
	Duel.SetTargetCard(tge)
end
function c511004444.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=tg:GetFirst()
	while tc do
		c:SetCardTarget(tc)
		tc=tg:GetNext()
	end
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c511004444.descon)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511004444.descon(e)
	return e:GetHandler():GetCardTargetCount()==0
end
function c511004444.atktg1(e,c)
	local g=e:GetLabelObject()
	return e:GetHandler():GetCardTarget():IsContains(c) and c:IsControler(e:GetHandlerPlayer()) and g:IsContains(c)
end
function c511004444.atkval1(e,c)
	return c:GetBaseAttack()
end
function c511004444.atktg2(e,c)
	local g=e:GetLabelObject()
	return e:GetHandler():GetCardTarget():IsContains(c) and c:IsControler(1-e:GetHandlerPlayer()) and not g:IsContains(c)
end
function c511004444.atkval2(e,c)
	return c:GetAttack()/2
end