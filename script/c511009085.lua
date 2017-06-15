--Double Sensor Ship
--fixed by MLD
function c511009085.initial_effect(c)
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009085.target)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000202,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511009085.atkcon)
	e2:SetTarget(c511009085.atktg)
	e2:SetOperation(c511009085.atkop)
	c:RegisterEffect(e2)
end
function c511009085.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511009085.atkcon(e,tp,Group.FromCards(a),ep,ev,re,r,rp) 
		and c511009085.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(511000202,0)) then
		e:SetOperation(c511009085.atkop)
		c511009085.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
	else
		e:SetOperation(nil)
	end
end
function c511009085.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return Duel.IsExistingMatchingCard(c511009085.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,a,a:GetCode())
end
function c511009085.filter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511009085.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511009085)==0 end
	e:GetHandler():RegisterFlagEffect(511009085,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511009085.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateAttack()
end
