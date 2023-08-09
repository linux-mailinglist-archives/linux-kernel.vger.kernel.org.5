Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57274775E10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjHILoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjHILoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:44:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE455A3;
        Wed,  9 Aug 2023 04:44:35 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLSnf54L6z1hwdY;
        Wed,  9 Aug 2023 19:41:42 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:44:32 +0800
Message-ID: <779c1483-5b24-5c01-6821-8699b17802c7@huawei.com>
Date:   Wed, 9 Aug 2023 19:44:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform notification
 for type4 and shared interrupt
To:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>
CC:     <robbiek@xsightlabs.com>, <guohanjun@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <wangkefeng.wang@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230801063827.25336-1-lihuisong@huawei.com>
 <20230801093831.dkamhtuvamjalhaa@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230801093831.dkamhtuvamjalhaa@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

kindly ping.


在 2023/8/1 17:38, Sudeep Holla 写道:
> Hi Rafael,
>
> On Tue, Aug 01, 2023 at 02:38:25PM +0800, Huisong Li wrote:
>> PCC supports processing platform notification for slave subspaces and
>> shared interrupt for multiple subspaces.
>>
> These changes have missed last 2 merge window. Let us know if you can pull
> this for v6.6 or you prefer to route this via mailbox.
>
