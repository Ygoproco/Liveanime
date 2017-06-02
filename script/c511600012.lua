--Elemental Hero Prisma (Anime)
--E・HERO プリズマー
--scripted by Larry126
function c511600012.initial_effect(c)
	--cos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89312388,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511600012.coscost)
	e1:SetOperation(c511600012.cosoperation)
	c:RegisterEffect(e1)
end
function c511600012.filter(c,code)
	return c:IsAbleToGraveAsCost() and c:IsCanBeFusionMaterial() and c:GetOriginalCode()~=code and c:IsType(TYPE_MONSTER)
end
function c511600012.coscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511600012.filter,tp,LOCATION_DECK,0,1,nil,e:GetHandler():GetCode()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c511600012.filter,tp,LOCATION_DECK,0,1,1,nil,e:GetHandler():GetCode())
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetFirst():GetOriginalCode())
end
function c511600012.cosoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetValue(e:GetLabel())
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511600012,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e2:SetLabelObject(e1)
	e2:SetOperation(c511600012.rstop)
	c:RegisterEffect(e2)
end
function c511600012.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=e:GetLabelObject()
	e1:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end