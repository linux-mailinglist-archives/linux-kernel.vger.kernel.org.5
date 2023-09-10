Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB4799E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjIJMWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 08:22:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E8CCA;
        Sun, 10 Sep 2023 05:22:48 -0700 (PDT)
X-UUID: be6908ac4fd411eea33bb35ae8d461a2-20230910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=dtivxyAoLfOdIaql3lkH6mw4eV2VKkW5u2UcK5oSezE=;
        b=n5lEap7Kidcc8CxprSigzlWcTplZ2YaWLAhJDZYWu7bO4ZEyD5s+QvUijJXn4SRJJdy7vjULwwQO3jtv98V1+XSDrTKlD5Rg6jnD+cb2XZP+KBRCvreDMv1fR68A0W6sSIwtYXC3tfiWRIUYc1j/jwkyyevFvMZrAyT/AzoZUrU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:3840d024-8979-4b39-94c2-fafdaf60dc9a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:70eda8be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be6908ac4fd411eea33bb35ae8d461a2-20230910
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 842297731; Sun, 10 Sep 2023 20:22:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 10 Sep 2023 20:22:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Sun, 10 Sep 2023 20:22:40 +0800
Message-ID: <3d5074ab-1348-1be8-0336-abb99a83a954@mediatek.com>
Date:   Sun, 10 Sep 2023 20:22:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
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
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
 <2318be3d-5687-8b6c-3669-1d2ae1c94d2c@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <2318be3d-5687-8b6c-3669-1d2ae1c94d2c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.220100-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9meN8m2FdGif1hE3O9q/rWIKe
        D7Y2MIwgwpcJm2NYlPAF6GY0Fb6yCsME2BsoiKJMi/vfAS7Q3HshTUkUhoUx9TqI/Q1zONHSqo2
        tkzpqPt34Qoz/MYokLGF9CsrxXKbN1G8rrdJV3qBA+s/DdZtQCyGi0ftsSkQynQqircTOm4dm+c
        CQxJJfxmeAopaL80nlab0g5A+bEfqAVaFa63RwvWwbuvhCHs3cqDcWbX2dmsmbKItl61J/ycnjL
        TA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sDgq/zEsC0P+ZuhST8Ev5CqLn04pTtjbDFcPD
        oU2tAmF4JZAFeiNCBQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.220100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5986BE42600B57F0903C511FE565CBE65C01D1CA80E18139D9C6138905BF66CA2000:8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/23 18:56, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do nost click links or open attachments until you 
> have verified the sender or the content.
> 
> On 09/09/2023 15:28, Macpaul Lin wrote:
>> 1. Add compatible for MT8395.
>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>> as the "Genio 1200-EVK".
>> 
>> The MT8195 and MT8395 belong to the same SoC family,
>> with only minor differences in their physical characteristics.
>> They utilize unique efuse values for differentiation.
>> 
>> The booting process and configurations are managed by boot
>> loaders, firmware, and TF-A. Consequently, the part numbers
>> and procurement channels vary.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Changes for v4:
Changes for v5:
  - No change, update Reviewed-by tag only. Thanks.

The explanation is here. The version v4 and v5 are the same.
For sending v5 is because "Patch v5 2/2" has been updated and these 2 
patches were in the same patch set. I think to update the whole patch 
set together with a single modified patch should be a usual operation.
Did I missing anything?

> Confusing. You just sent a patch changing the same hunk - adding
> description, without any explanation.
> 

The marketing naming rule of MediaTek SOCs are usually confusing people. 
I guess the previous patch just confused you. Ha.

MT8365 - Genio 350 chip.
MT8395 - Genio 1200 chip.
And upcoming patches (still under working).
MT8390 - Genio 700 chip.

> Best regards,
> Krzysztof
> 

Thanks
Macpaul Lin
