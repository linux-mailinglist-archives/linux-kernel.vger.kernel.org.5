Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9E79CA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjILIkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjILIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:40:16 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728910C4;
        Tue, 12 Sep 2023 01:40:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vrw4LF-_1694508008;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vrw4LF-_1694508008)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:40:08 +0800
Message-ID: <682f9cf8-10ab-fd89-7eea-97274f81ac4c@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 16:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 0/6] pinctrl: sprd: Modification of UNIOC Platform
 pinctrl Driver
To:     Linus Walleij <linus.walleij@linaro.org>,
        Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <CACRpkdbUOM7KD2h+mSZ4xj7UCCe_Gj_Dzcc7hSmOfOftve_kyg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CACRpkdbUOM7KD2h+mSZ4xj7UCCe_Gj_Dzcc7hSmOfOftve_kyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 9:41 PM, Linus Walleij wrote:
> On Fri, Sep 8, 2023 at 7:52 AM Linhua Xu <Linhua.xu@unisoc.com> wrote:
> 
>> From: Linhua Xu <Linhua.Xu@unisoc.com>
>>
>> Recently, some bugs have been discovered during use, and patch2 and patch3
>> are bug fixes. Also, this patchset add new features: patch1 is for
>> compatibility with more platforms, patch4 add pinctrl support for UMS512,
>> patch5 Increase the range of register values, patch6 add pinctrl support
>> for UMS9621.
>>
>> change in V2
> 
> V2 is starting to look good, please address Andy's comments, especially
> move the fixes first in the series so they can be queued as fixes
> if need be.

Yes, agree. Please send the fix patches separately with proper Fixes tag.

> 
> I would really appreciate if Baolin can review the patches as well as
> he knows this hardware very well and wrote the initial version.

Sure.
