Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8F79A5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjIKIRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjIKIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:17:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802CBB;
        Mon, 11 Sep 2023 01:16:55 -0700 (PDT)
X-UUID: 8e1f4736507b11ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=bLtsrzjxUtfjRXBTdg7ryD78RZbIUqX7HT6UlqEs7uw=;
        b=UebW4fkJT4sinEnIj28vlOHdnCLNyrqN35wRKpPbWXzbYjEk4X/G0Ig3TIfNRKKKW0AZ0SKzcd78MAGk483f1viXvf3r18sF9tu9Tpzd+J8UYuZ+q7xkijAZbmQPixncfzCEJ9CxIqOJNWrnIKrJmur3C0OF1ODuCZmqGT+gY10=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8e07ecf4-4cd3-4904-8247-805cc914e292,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:0b69b1be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8e1f4736507b11ee8051498923ad61e6-20230911
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 332041101; Mon, 11 Sep 2023 16:16:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 16:16:47 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 11 Sep 2023 16:16:45 +0800
Message-ID: <e697a23e-e677-c97b-269a-a7a11d338d95@mediatek.com>
Date:   Mon, 11 Sep 2023 16:16:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230910062852.15415-1-macpaul.lin@mediatek.com>
 <f8864242-daa1-e72f-4759-aac3fa1bbcf2@linaro.org>
 <12bdd17a-98f4-5551-4253-229dc36f0c77@mediatek.com>
 <ef81697f-473e-898e-ec13-4dd255e2e3d7@linaro.org>
 <82a0ab25-a3cc-3e87-e379-9b15b3fbbf76@mediatek.com>
 <649e89c3-343a-c00c-ae89-329833b38981@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <649e89c3-343a-c00c-ae89-329833b38981@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.294500-8.000000
X-TMASE-MatchedRID: +f/wAVSGjujsYbGmK/WYxia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yChLn4nGgmm6XPJAf1AuYU6BbVWMeHOeZaFc/CedjlcvkASS
        25Kb4JAK/PxUCMpGeRFQXB1s+iArFOkjQDRo1OZRor4yxPAz7WQ2AVSpm3nkDATjAbArJUsiqHZ
        Z4aC7fIyJtQogTap1vmw8gErCz5evsPLr8JwjnkLGj3LN0+Ey97yrmaqIg0yAwEhHW5KVAz2J+P
        WmHAknxnlSM1mB4TLLOHyiFumtKQSnixsypv8PSFPowz8xfffSeimGtNywjtpsoi2XrUn/JyeMt
        MD9QOgChMIDkR/KfwI2j49Ftap9EOwBXM346/+zxKm+NrlRaJHxJwMK8LeRQaDATuz7r6ZYNxer
        6R4Ih84VxIm5v/HGf
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.294500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6EEA80FCF1E52590F8061DE403ECC5A07550DF81B15E6C606221868D3A8DE3472000:8
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 15:06, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 11/09/2023 08:34, Macpaul Lin wrote:
>> On 9/11/23 14:09, Krzysztof Kozlowski wrote:
>>> 
>>>
>>> External email : Please do not click links or open attachments until you 
>>> have verified the sender or the content.
>>>
>>> On 10/09/2023 14:07, Macpaul Lin wrote:
>>>>
>>>>
>>>> On 9/10/23 17:09, Krzysztof Kozlowski wrote:
>>>>>> +      - description: MediaTek Genio 350 Boards (Genio 350 EVK)
>>>>>
>>>>> That's a bit confusing. So all of the boards here will be Genio 350 EVK?
>>>>> I don't get what is the point of this description.
>>>>>
>>>>>
>>>>>> +        items:
>>>>>>            - enum:
>>>>>>                - mediatek,mt8365-evk
>>>>>>            - const: mediatek,mt8365
>>>>
>>>> Thes boards with compatible 'mediatek,mt8365-evk' is indeed used by
>>>
>>> Boards?
>> 
>> I'm not sure if there will be more hardware version released to market.
>> Current the p1v3 is the final version of mt8365-evk.
> 
> Then your code (enum) does not match description. The code is saying:
> this is for multiple boards based on mt8365.
> 
> Your description is saying: this is only for 350 boards.
> 
> Now your email is saying: there is only one 350 board.
> 
> Three different versions. Sorry, I am confused.
> 

Okay, this description has been modified to support single board.
Since there is only one type of the hardware is available on the market.

>> 
>>>> Genio 350-EVK, which Baylibre helped to do upstream tasks. The only 
>>>> production version of hardware will be available on the market. The 
>>>> derived version of customer's hardware is not available yet.
>>>>
>>>> The separate patch for renaming mt8365-evk.dts file should be send next 
>>>> week for aligning the naming rules.
>>>
>>> So the description is not correct.
>>>
>>> Anyway, this patch does not make much sense to me considering nothing
>>> like this was merged. You just sent v5 doing the same!
>> 
>> 
>> Sorry I'm confused now.
>> These are independent patches.
>> This patch is for SOC mt83'6'5 and board mt8365-evk, which is not relate 
>> SOC mt83'9'5 and board mt8395-evk.
> 
> OK, I see my confusion. mt8365 and mt8395.
> 
> Still the description is not matching the code, at least to my limited
> understanding of the description.
> 

patch v2 of this change has been send and rebase with that v5 change.
This will generate a different base line for the v2 patch for avoiding 
confusion. :)


> Best regards,
> Krzysztof
> 

Thanks
Macpaul Lin
