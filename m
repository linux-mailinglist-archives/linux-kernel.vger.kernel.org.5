Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26DF7E66F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKIJoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKIJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:44:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0B272C;
        Thu,  9 Nov 2023 01:44:02 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQxqB44W1zfb6H;
        Thu,  9 Nov 2023 17:43:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 9 Nov
 2023 17:43:34 +0800
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
 <20231107094959.556ffe53@kernel.org>
 <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
 <20231108084739.59adead6@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <bcf61cb5-1203-7de5-4db1-85a96bd84130@huawei.com>
Date:   Thu, 9 Nov 2023 17:43:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231108084739.59adead6@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/9 0:47, Jakub Kicinski wrote:
> On Wed, 8 Nov 2023 11:31:45 +0800 Yunsheng Lin wrote:
>> For 2, yes, maybe I should stick to the rule even if it is a simple
>> patch and obivous format error.
> 
> Yes, maybe you should.

Thanks for clarifying.
Maybe I should be targetting the net-next branch for the repost
after merge window open, in order not to cause any confusion.

> .
> 
