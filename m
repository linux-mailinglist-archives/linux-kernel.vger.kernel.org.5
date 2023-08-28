Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F878A401
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjH1Ble (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjH1BlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:41:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE73113
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:41:02 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RYtV46PcGzJrlc;
        Mon, 28 Aug 2023 09:37:48 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 09:40:58 +0800
Message-ID: <7d337ca9-652e-7612-8769-1e0e0ca773ab@huawei.com>
Date:   Mon, 28 Aug 2023 09:40:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <jonathan.cameron@huawei.com>,
        <mark.rutland@arm.com>, <yangyicong@hisilicon.com>,
        <chenhao418@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: Update
 HiSilicon PMU maintainers
To:     Will Deacon <will@kernel.org>, Zenghui Yu <zenghui.yu@linux.dev>
References: <20230824024135.1291459-1-shaojijie@huawei.com>
 <9009693a-0314-9526-e57f-1b2302abfd7e@linux.dev>
 <20230825102522.GA24076@willie-the-truck>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230825102522.GA24076@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/25 18:25, Will Deacon wrote:
> drivers/perf/hisilicon/hns3_pmu.c
>> You probably need to move the entry around to keep things ordered
>> (see commit 80e62bc8487b).
> I'll just leave the title of the entry as it is to avoid the churn.
>
> Will

Thanks!

Jijie Shao

