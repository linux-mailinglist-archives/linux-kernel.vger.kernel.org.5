Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73B77184D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHGCXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:23:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22FD95;
        Sun,  6 Aug 2023 19:23:16 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RK0S220BKzVjsm;
        Mon,  7 Aug 2023 10:21:22 +0800 (CST)
Received: from [10.67.101.184] (10.67.101.184) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:23:13 +0800
Subject: Re: [PATCH 1/7] crypto: hisilicon/qm - obtain the mailbox
 configuration at one time
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20230729125239.25337-1-qianweili@huawei.com>
 <20230729125239.25337-2-qianweili@huawei.com>
 <ZMy2LQckr/OtS1ZG@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <6af919d6-755e-4cc3-794d-2684e58d01fe@huawei.com>
Date:   Mon, 7 Aug 2023 10:23:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ZMy2LQckr/OtS1ZG@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/4 16:26, Herbert Xu wrote:
> Your patch description makes no sense to me.  Please explain more
> clearly why you're replacing generic IO primitives with hand-rolled
> assembly.

Sorry，I will re-describe the problem that this patch fixes.

Thanks,
Weili
