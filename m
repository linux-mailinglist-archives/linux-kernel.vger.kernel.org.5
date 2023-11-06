Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DB7E1A28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKFGSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:18:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADC0112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:18:31 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SP1PP4YswzVk7x;
        Mon,  6 Nov 2023 14:18:17 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 14:18:26 +0800
Subject: Re: [PATCH] ubifs: auth.c: fix kernel-doc function prototype warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
References: <20231106060744.10847-1-rdunlap@infradead.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <97389b3e-ae43-a344-333f-e74281c0fef9@huawei.com>
Date:   Mon, 6 Nov 2023 14:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231106060744.10847-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/11/6 14:07, Randy Dunlap Ð´µÀ:
> Use the correct function name in the kernel-doc comment to prevent
> a kernel-doc warning:
>
> auth.c:30: warning: expecting prototype for ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202311052125.gE1Rylox-lkp@intel.com
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
>   fs/ubifs/auth.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
