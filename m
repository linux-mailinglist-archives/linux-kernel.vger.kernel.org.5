Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2EE7EDCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjKPIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKPIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:23:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DB21AE;
        Thu, 16 Nov 2023 00:23:07 -0800 (PST)
X-UUID: 59426662845911ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=8cExeY03ycwS+hRbiJaT4XqSqtteas/8iz3rsWbaWrc=;
        b=TATRtYeeI3MjbhLOsWTiiy9Kscc1hPr6ZotvOu2Nefn62mB93s07F80x2VgKzWHMLeyFzUH7sGusPOvaiU0Xgzu+HEIaavzxN7QdZKBd88J/PWE15dTVL6vjc1e+yaTbrLvqNs9ODZyhr2tyVWh+qcYGJ/H1Awusw6Kgx2+ZBjs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ac3e77b3-5c62-42d5-98ba-64e3872566fe,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:287f99fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 59426662845911ee8051498923ad61e6-20231116
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1978411075; Thu, 16 Nov 2023 16:22:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 16:22:56 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 16 Nov 2023 16:22:50 +0800
Message-ID: <d9cc9f00-69e5-dd06-cac4-7a6dab0dabf1@mediatek.com>
Date:   Thu, 16 Nov 2023 16:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] scsi: ufs: mediatek: Change the maintainer for
 MediaTek UFS hooks
Content-Language: en-US
To:     Stanley Jhu <chu.stanley@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <peter.wang@mediatek.com>
CC:     <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
References: <20231116030123.10820-1-chu.stanley@gmail.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20231116030123.10820-1-chu.stanley@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.164400-8.000000
X-TMASE-MatchedRID: 6otD/cJAac3lpCXYECeZbya1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCvQYZJBBoF8Rh6L+ZkJhXC6ANGXBz7BHpyJ8zskw0dbr0Du
        2Dq3CQetkfYhY73aF9FzzIJrqcl2Q49E2aI0sGmEpoxDq3DugMlQQ0EgzIoPRIFBEE5CFomKY2X
        zxFRZR86tltIUUHBSWt2cI2StQCc0ryFHbNnBLGz2C05EXD5W80w14HFJQjaP0i0LZ2ZefXRwbB
        +iCKX6CF1pImo9Cx0VV8FbLD3om6QDBaeVuVh0CW7gz/Gbgpl59LQinZ4QefL6qvLNjDYTwsuf7
        RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.164400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0FA6FB6069DE4962721B3F66BA0F3B6831940FBF97A971466076C9ED8FC03D602000:8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 11:01, Stanley Jhu wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> 
> Change the maintainer of MediaTek UFS hooks to Peter Wang.
> In the meantime, Stanley has been assigned as the reviewer.
> 
> The original maintainer, Stanley Chu, who can be reached at
> stanley.chu@mediatek.com, has left MediaTek,
> so please update the email address accordingly.
> 
> Signed-off-by: Stanley Jhu <chu.stanley@gmail.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be1cbc6c2059..4f6fb3357947 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22102,7 +22102,8 @@ S:	Maintained
>   F:	drivers/ufs/host/ufs-exynos*
>   
>   UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
> -M:	Stanley Chu <stanley.chu@mediatek.com>
> +M:	Peter Wang <peter.wang@mediatek.com>
> +R:	Stanley Jhu <chu.stanley@gmail.com>
>   L:	linux-scsi@vger.kernel.org
>   L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained

I could also prove the user of Stanley Chu <stanley.chu@mediatek.com> 
and Stanley Jhu <chu.stanley@gmail.com> is the same. I guess we've 
better to replace the email in MAINTAINERS before we change our jobs. :p

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

Thanks for the contribution to public domain and excellent work in 
MediaTek from Stanley previously.

Best regards,
Macpaul Lin
