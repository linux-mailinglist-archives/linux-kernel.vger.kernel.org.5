Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125097E504F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKHG1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHG1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:27:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF010C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:27:14 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SQFPy72S5zPp7c;
        Wed,  8 Nov 2023 14:23:02 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 14:16:36 +0800
Subject: Re: [PATCH] ubifs: describe function parameters
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20231108060506.2976328-1-s.hauer@pengutronix.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ddaee23b-8e7e-eec0-9db1-7aa67bd845bd@huawei.com>
Date:   Wed, 8 Nov 2023 14:16:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231108060506.2976328-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/11/8 14:05, Sascha Hauer Ð´µÀ:
> With 16a26b20d2afd ("ubifs: authentication: Add hashes to index nodes")
> insert_node() and insert_dent() got a new function parameter 'hash'. Add
> a description for this new parameter.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311051618.D7YUE1Rr-lkp@intel.com/
> ---
>   fs/ubifs/replay.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

