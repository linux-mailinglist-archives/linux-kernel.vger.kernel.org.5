Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B983786502
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbjHXCAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbjHXCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:00:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC5E6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:00:07 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWR5H1LkQztSKJ;
        Thu, 24 Aug 2023 09:56:19 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 10:00:03 +0800
Message-ID: <daeec014-c642-c4c0-5b28-eac4eca3aa3d@huawei.com>
Date:   Thu, 24 Aug 2023 10:00:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <yangyicong@huawei.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <hejunhao3@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH drivers/perf: hisi:] drivers/perf: hisi: Update email
 addresses of HISILICON_PMU driver maintainers.
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230822122812.2384393-1-shaojijie@huawei.com>
 <20230823090811.00001f7f@Huawei.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230823090811.00001f7f@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/23 16:08, Jonathan Cameron wrote:
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Best wishes and thanks to them both and thanks to yangyicong and
> shaojijie for stepping up.
>
>
> Bit late now, but with hindsight it might have been better
> to use the same wording for the HNS3 PMU as for HNS itself
>
> HISILICON NETWORK SUBSYSTEM 3 PMU Driver (HNS3 PMU)
> so that it would appear in the obviously place in MAINTAINERS
> rather than a few lines further up.  Probably not worth
> the noise of changing it however.
>
> Jonathan
>
Hi,
Yeah, I agree. and I think it's worth changing, and I'll change it in V2.

Jijie Shao

>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4171d3a102a9..a3109267a411 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9305,7 +9305,7 @@ F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
>>   F:	drivers/crypto/hisilicon/hpre/hpre_main.c
>>   
>>   HISILICON HNS3 PMU DRIVER
>> -M:	Guangbin Huang <huangguangbin2@huawei.com>
>> +M:	Jijie Shao <shaojijie@huawei.com>
>>   S:	Supported
>>   F:	Documentation/admin-guide/perf/hns3-pmu.rst
>>   F:	drivers/perf/hisilicon/hns3_pmu.c
>> @@ -9343,7 +9343,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
>>   F:	drivers/net/ethernet/hisilicon/
>>   
>>   HISILICON PMU DRIVER
>> -M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
>> +M:	Yicong Yang <yangyicong@hisilicon.com>
>>   M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>>   S:	Supported
>>   W:	http://www.hisilicon.com
