--Masahiro the Dark Clown
function c511000988.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000988,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c511000988.target)
	e1:SetOperation(c511000988.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(TYPE_NORMAL)
	c:RegisterEffect(e2)
end
c511000988.illegal=true
function c511000988.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsType(TYPE_FLIP) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,1,1,nil,TYPE_FLIP)
end
function c511000988.cfilter(c)
	return c:IsType(TYPE_FLIP) and c:GetOriginalCode()~=511000988
end
function c511000988.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		if tc:GetOriginalCode()~=511000988 then
			c:ReplaceEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000)
		end
		if tc:GetOriginalCode()~=511000988 or Duel.IsExistingTarget(c511000988.cfilter,tp,LOCATION_GRAVE,0,1,nil) then
			Duel.RaiseSingleEvent(c,EVENT_FLIP,e,r,rp,ep,ev)
		end
	end
end
