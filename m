Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C80782926
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjHUMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjHUMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:33:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F4194
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:33:13 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTsKM4FqwzrSKX;
        Mon, 21 Aug 2023 20:31:19 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 20:32:46 +0800
Message-ID: <55fc4ac5-0470-2555-240b-7cbf271c2dd6@huawei.com>
Date:   Mon, 21 Aug 2023 20:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <huangguangbin2@huawei.com>, <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH drivers/perf: hisi: 2/2] drivers/perf: hisi: fix set wrong
 filter mode for running events issue
To:     Will Deacon <will@kernel.org>
References: <20230816094619.3563784-1-shaojijie@huawei.com>
 <20230816094619.3563784-3-shaojijie@huawei.com>
 <20230821120440.GB19617@willie-the-truck>
 <20230821120812.GC19617@willie-the-truck>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230821120812.GC19617@willie-the-truck>
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


on 2023/8/21 20:08, Will Deacon wrote:
> <zhangshaokun@hisilicon.com>: host mx5.hisilicon.com[124.71.93.234] said: 551
>      5.1.1 <zhangshaokun@hisilicon.com>: Recipient address rejected: Failed
>      recipient validation check.: host 127.0.0.1[127.0.0.1] said: 554 5.7.1
>      recipient verify from ldap failed (in reply to RCPT TO command) (in reply
>      to RCPT TO command)
>
> <huangguangbin2@huawei.com>: host mx5.huawei.com[124.71.93.234] said: 551 5.1.1
>      <huangguangbin2@huawei.com>: Recipient address rejected: Failed recipient
>      validation check.: host 127.0.0.1[127.0.0.1] said: 554 5.7.1 recipient
>      verify from ldap failed (in reply to RCPT TO command) (in reply to RCPT TO
>      command)
>
>
> So it's only Jonathan left in MAINTAINERS for "HISILICON HNS3 PMU DRIVER".
> Lucky him!
>
> Please can you update MAINTAINERS?
>
> Will


We will update MAINTAINERS shortly

Jijie Shao

