--E・HERO ストーム・ネオス
function c511023007.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,89943723,17955766,54959865,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511023007.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511023007.spcon)
	e2:SetOperation(c511023007.spop)
	c:RegisterEffect(e2)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511023007,0))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511023007.retcon1)
	e3:SetTarget(c511023007.rettg)
	e3:SetOperation(c511023007.retop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(0)
	e4:SetCondition(c511023007.retcon2)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511023007,1))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c511023007.destg)
	e5:SetOperation(c511023007.desop)
	c:RegisterEffect(e5)
end
c511023007.material_setcode=0x8
function c511023007.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end
function c511023007.spfilter(c,code1,code2,code3)
	return c:IsAbleToDeckOrExtraAsCost() and (c:IsFusionCode(code1) or c:IsFusionCode(code2) or c:IsFusionCode(code3))
end
function c511023007.spfilter1(c,mg,ft)
	local mg2=mg:Clone()
	mg2:RemoveCard(c)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return ft>=-1 and c:IsFusionCode(89943723) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial()
		and mg2:IsExists(c511023007.spfilter2,1,nil,mg2,ft)
end
function c511023007.spfilter2(c,mg,ft)
	local mg2=mg:Clone()
	mg2:RemoveCard(c)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return ft>=0 and c:IsFusionCode(17955766) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial()
		and mg2:IsExists(c511023007.spfilter3,1,nil,ft)
end
function c511023007.spfilter3(c,ft)
	if c:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	return ft>=1 and c:IsFusionCode(54959865) and c:IsAbleToDeckOrExtraAsCost() and c:IsCanBeFusionMaterial()
end
function c511023007.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<-2 then return false end
	local mg=Duel.GetMatchingGroup(c511023007.spfilter,tp,LOCATION_ONFIELD,0,nil,89943723,17955766,54959865)
	return mg:IsExists(c511023007.spfilter1,1,nil,mg,ft)
end
function c511023007.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local mg=Duel.GetMatchingGroup(c511023007.spfilter,tp,LOCATION_ONFIELD,0,nil,89943723,17955766,54959865)
	local g=Group.CreateGroup()
	local tc=nil
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		if i==1 then
			tc=mg:FilterSelect(tp,c511023007.spfilter1,1,1,nil,mg,ft):GetFirst()
		end
		if i==2 then
			tc=mg:FilterSelect(tp,c511023007.spfilter2,1,1,nil,mg,ft):GetFirst()
		end
		if i==3 then
			tc=mg:FilterSelect(tp,c511023007.spfilter3,1,1,nil,ft):GetFirst()
		end
		g:AddCard(tc)
		mg:RemoveCard(tc)
		if tc:IsLocation(LOCATION_MZONE) then ft=ft+1 end
	end
	local cg=g:Filter(Card.IsFacedown,nil)
	if cg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c511023007.retcon1(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsHasEffect(42015635)
end
function c511023007.retcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(42015635)
end
function c511023007.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtra() end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c511023007.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
	if c:IsLocation(LOCATION_EXTRA) then
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+511023007,e,0,0,0,0)
	end
end
function c511023007.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511023007.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511023007.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c511023007.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511023007.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511023007.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end