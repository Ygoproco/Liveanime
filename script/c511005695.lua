--Goblin Fan (DOR)
--scripted by GameMaster(GM)
function c511005695.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511005695.condition)
	e1:SetTarget(c511005695.rectg)
	e1:SetOperation(c511005695.activate)
	c:RegisterEffect(e1)
	--Returns LP when Riryoku anime/DOR 
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c511005695.condition)
	e2:SetOperation(c511005695.activate)
	e2:SetTarget(c511005695.rectg)
	c:RegisterEffect(e2)
end

function c511005695.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end 
end

function c511005695.repop(e,tp,eg,ep,ev,re,r,rp)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
local p=e:GetHandler():GetControler()
 Duel.SetLP(tp,Duel.GetLP(p)/2,REASON_EFFECT)
 local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(Duel.GetLP(p))
		tc:RegisterEffect(e1)
	end
end

function c511005695.condition(e,tp,eg,ep,ev,re,r,rp)
   return re:IsHasType(EFFECT_TYPE_ACTIVATE,511000474) and (re:GetHandler():GetOriginalCode()==511000474 or re:GetHandler():GetOriginalCode()==511005686) and e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end

function c511005695.activate(e,tp,eg,ep,ev,re,r,rp)
local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c511005695.repop)
end
