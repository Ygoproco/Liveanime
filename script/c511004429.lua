--Abyss Impromptu Play - Improv
--fixed by MLD
function c511004429.initial_effect(c)
	--batturo
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetTarget(c511004429.target)
	e1:SetOperation(c511004429.activate)
	c:RegisterEffect(e1)
end
function c511004429.filter(c,g)
	return c:IsFaceup() and c:IsSetCard(0x10ec) and c:GetLevel()<=4 and not g:IsContains(c)
end
function c511004429.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local g=Group.FromCards(a,d)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511004429.filter(chkc,g) end
	if chk==0 then return d and g:IsExists(Card.IsControler,1,nil,1-tp)
		and Duel.IsExistingTarget(c511004429.filter,tp,LOCATION_MZONE,0,1,nil,g) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511004429.filter,tp,LOCATION_MZONE,0,1,1,nil,g)
end
function c511004429.activate(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e1:SetCountLimit(1)
		e1:SetOperation(c511004429.rdop)
		e1:SetLabel(tc:GetAttack())
		Duel.RegisterEffect(e1,tp)
	end
end
function c511004429.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev+e:GetLabel())
end
