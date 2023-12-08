Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A8809D04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjLHHSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLHHSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:18:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52FDD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:18:38 -0800 (PST)
Received: from kwepemd100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Smj7n1PYYzsRnN;
        Fri,  8 Dec 2023 15:14:45 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd100008.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Fri, 8 Dec
 2023 15:18:34 +0800
Message-ID: <6572C34A.7010101@hisilicon.com>
Date:   Fri, 8 Dec 2023 15:18:34 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Huisong Li <lihuisong@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <arnd@arndb.de>, <krzk@kernel.org>,
        <sudeep.holla@arm.com>, <liuyonglong@huawei.com>,
        <xuwei5@hisilicon.com>
Subject: Re: [PATCH v3 0/5] soc: hisilicon: kunpeng_hccs: Support the platform
 with PCC type3 and interrupt ack
References: <20231109054526.27270-1-lihuisong@huawei.com> <20231201034534.7276-1-lihuisong@huawei.com>
In-Reply-To: <20231201034534.7276-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100008.china.huawei.com (7.221.188.193)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huisong,

On 2023/12/1 11:45, Huisong Li wrote:
> The main purpose of this series is to support the platform with PCC type3
> and interrupt ack. At the same time, this series also fix some clean codes
> and modify the incorrect email domain name.
> 
> ---
>  v3:
>   - remove inline tag of two wait_cmd_complete function.
>   - delete variable 'ret' in hccs_wait_cmd_complete_by_irq()
>   - add a new patch which fix incorrect email domain name in document.
> 
>  v2:
>   - using a version specific structure to replace device version according
>     to Jonathan's advice.
>   - add a new patch that remove an unused blank line.
> 
> Huisong Li (5):
>   soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
>   soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
>   soc: hisilicon: kunpeng_hccs: Remove an unused blank line
>   doc: kunpeng_hccs: Fix incorrect email domain name
>   soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 and
>     interrupt ack
> 
>  .../sysfs-devices-platform-kunpeng_hccs       |   6 +-
>  drivers/soc/hisilicon/kunpeng_hccs.c          | 152 ++++++++++++++----
>  drivers/soc/hisilicon/kunpeng_hccs.h          |  15 ++
>  3 files changed, 137 insertions(+), 36 deletions(-)
> 

Thanks!
Series applied to the HiSilicon driver tree.

Best Regards,
Wei
