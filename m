Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E47E4126
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjKGNvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:50:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B222883;
        Tue,  7 Nov 2023 04:40:24 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SPnm82S4TzrT4R;
        Tue,  7 Nov 2023 20:37:12 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 7 Nov
 2023 20:40:22 +0800
Subject: Re: [PATCH net] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
To:     Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231107113440.59794-1-linyunsheng@huawei.com>
 <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <05ae3fef-69d4-2505-872a-89df9f668545@huawei.com>
Date:   Tue, 7 Nov 2023 20:40:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/7 20:28, Jesper Dangaard Brouer wrote:

>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14e1194faa4b..5d20efb9021a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16242,6 +16242,7 @@ F:    mm/truncate.c
>>   PAGE POOL
>>   M:    Jesper Dangaard Brouer <hawk@kernel.org>
>>   M:    Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> +R    Yunsheng Lin <linyunsheng@huawei.com>
> 
> I think there is missing a colon ":" after "R".

Yes, thanks for pointing out.
Fixed and sent.

> 
>>   L:    netdev@vger.kernel.org
>>   S:    Supported
>>   F:    Documentation/networking/page_pool.rst
> 
> .
> 
