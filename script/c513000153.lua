--Speed Spell - Sonic Buster (Anime)
--Ｓｐ－ソニック・バスター
--scripted by Larry126
function c513000153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000153.con)
	e1:SetTarget(c513000153.target)
	e1:SetOperation(c513000153.activate)
	c:RegisterEffect(e1)
end
function c513000153.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>3
end
function c513000153.filter(c,tp)
	local atk=c:GetAttack()/2
	return c:IsFaceup() and Duel.GetLP(1-tp)>atk
end
function c513000153.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c513000153.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c513000153.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,c513000153.filter,tp,LOCATION_MZONE,0,1,1,nil,tp):GetFirst()
	if tc and tc:IsFaceup() then
		Duel.Damage(1-tp,tc:GetAttack()/2,REASON_EFFECT)
	end
end