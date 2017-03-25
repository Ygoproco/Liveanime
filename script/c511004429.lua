--Abyss Impromptu Play - Improv
function c511004429.initial_effect(c)
	--batturo
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetTarget(c511004429.target)
	e1:SetOperation(c511004429.operation)
	c:RegisterEffect(e1)
end
function c511004429.filter(c,a,d)
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:GetLevel()<=4 and not (c==a or c==d)
end
function c511004429.target(e,tp,eg,ev,ep,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chk==0 then return d and (a:IsControler(1-tp) or d:IsControler(1-tp))
		and Duel.IsExistingTarget(c511004429.filter,tp,LOCATION_MZONE,0,1,nil,a,d) end
	local tg=Duel.SelectTarget(tp,c511004429.filter,tp,LOCATION_MZONE,0,1,1,nil,a,d)
end
function c511004429.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	if not tg or not tg:IsRelateToEffect(e) then return end
	local atk=tg:GetAttack()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e1:SetCountLimit(1)
	e1:SetOperation(c511004429.rdop)
	e1:SetLabel(atk)
	Duel.RegisterEffect(e1,tp)
end
function c511004429.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev+e:GetLabel())
end