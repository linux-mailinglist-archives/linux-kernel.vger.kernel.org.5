Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1047661B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjG1CUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjG1CUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:20:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF852D73
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:20:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBrtW2BsQz1GD9B;
        Fri, 28 Jul 2023 10:19:31 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 10:20:26 +0800
Subject: Re: [PATCH v2 0/4] A few fixup patches for mm
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230727115643.639741-1-linmiaohe@huawei.com>
 <20230727095701.98b4dba128292d0128f44858@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b0d91f3f-764d-59d1-98c1-95fa6788cb2a@huawei.com>
Date:   Fri, 28 Jul 2023 10:20:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230727095701.98b4dba128292d0128f44858@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/28 0:57, Andrew Morton wrote:
> On Thu, 27 Jul 2023 19:56:39 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> This series contains a few fixup patches to fix potential unexpected
>> return value, fix wrong swap entry type for hwpoisoned swapcache page
>> and so on. More details can be found in the respective changelogs.
> 
> I'm thinking that patches 1-3 should be backported into -stable kernels.
> Thoughts on this?

I tend to backport the patches 1-3. They helps.

Thanks Andrew.

