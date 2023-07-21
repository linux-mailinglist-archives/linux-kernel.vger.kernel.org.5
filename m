Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B475C6E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGUMbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGUMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:31:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0719B0;
        Fri, 21 Jul 2023 05:31:16 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6pmd38mNz18Lfm;
        Fri, 21 Jul 2023 20:30:25 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 20:31:11 +0800
Message-ID: <0bb5ca67-304e-c40c-c423-947c682d1b88@huawei.com>
Date:   Fri, 21 Jul 2023 20:31:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
To:     <rafael.j.wysocki@intel.com>, <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robbie King <robbiek@xsightlabs.com>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230613125728.31279-1-lihuisong@huawei.com>
 <20230614155842.7j3d6hdx7mmnhghd@bogus>
 <f9ce7a98-5742-59cf-9844-03b0ac9bb526@huawei.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <f9ce7a98-5742-59cf-9844-03b0ac9bb526@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Kindly ping.

在 2023/7/14 14:39, lihuisong (C) 写道:
> Hi Rafael,
>
> Can you merge this series if it is ok for you.
> They've already missed two merge windows.😁
>
> Regards,
> Huisong
>
>
> 在 2023/6/14 23:58, Sudeep Holla 写道:
>> Hi Rafael,
>>
>> On Tue, Jun 13, 2023 at 08:57:26PM +0800, Huisong Li wrote:
>>> PCC supports processing platform notification for slave subspaces and
>>> shared interrupt for multiple subspaces.
>>>
>> Can you pick up these patches please ?
>> It missed last merge window narrowly as I didn't want to push it that 
>> late.
>> So it would be good to get this in this time around.
>>
> .
