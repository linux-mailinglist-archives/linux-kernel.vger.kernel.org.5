Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024F78BEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjH2HLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjH2HLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:11:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46149F7;
        Tue, 29 Aug 2023 00:11:02 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZdnH1GQZzVjyb;
        Tue, 29 Aug 2023 15:08:35 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 15:10:59 +0800
Message-ID: <75f04346-7776-0bd0-19c9-c63f2f329f56@hisilicon.com>
Date:   Tue, 29 Aug 2023 15:10:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] cpufreq: Support per-policy performance boost
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuwei5@huawei.com>, <wanghuiqiang@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangxiongfeng2@huawei.com>
References: <20230822124837.3016641-1-zhanjie9@hisilicon.com>
 <20230825063926.n4o7cp6x56r5i2it@vireshk-i7>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230825063926.n4o7cp6x56r5i2it@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2023 14:39, Viresh Kumar wrote:
> Looks good now, thanks.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Many thanks!

Jie
