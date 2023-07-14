Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5747753223
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGNGjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGNGjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:39:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A382D66;
        Thu, 13 Jul 2023 23:39:34 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R2MFV5PmrztRWB;
        Fri, 14 Jul 2023 14:36:30 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 14:39:31 +0800
Message-ID: <f9ce7a98-5742-59cf-9844-03b0ac9bb526@huawei.com>
Date:   Fri, 14 Jul 2023 14:39:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230613125728.31279-1-lihuisong@huawei.com>
 <20230614155842.7j3d6hdx7mmnhghd@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230614155842.7j3d6hdx7mmnhghd@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Can you merge this series if it is ok for you.
They've already missed two merge windows.😁

Regards,
Huisong


在 2023/6/14 23:58, Sudeep Holla 写道:
> Hi Rafael,
>
> On Tue, Jun 13, 2023 at 08:57:26PM +0800, Huisong Li wrote:
>> PCC supports processing platform notification for slave subspaces and
>> shared interrupt for multiple subspaces.
>>
> Can you pick up these patches please ?
> It missed last merge window narrowly as I didn't want to push it that late.
> So it would be good to get this in this time around.
>
