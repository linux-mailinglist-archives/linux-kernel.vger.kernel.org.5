Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F67DC498
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjJaCm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Oct 2023 22:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjJaCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:42:55 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9C9F;
        Mon, 30 Oct 2023 19:42:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvFn5Tf_1698720167;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VvFn5Tf_1698720167)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 10:42:47 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix incorrect descriptions for
 GRPCFG register
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <656d4735-0e24-c9d8-ba9c-97f079d95475@intel.com>
Date:   Tue, 31 Oct 2023 10:42:46 +0800
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        tony.luck@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de
Content-Transfer-Encoding: 8BIT
Message-Id: <A4F5CA4D-81D9-478B-9A9B-844BD15CBB32@linux.alibaba.com>
References: <20231031023700.1515974-1-guanjun@linux.alibaba.com>
 <20231031023700.1515974-3-guanjun@linux.alibaba.com>
 <656d4735-0e24-c9d8-ba9c-97f079d95475@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023年10月31日 上午10:39，Fenghua Yu <fenghua.yu@intel.com> 写道：
> 
> 
> 
> On 10/30/23 19:37, 'Guanjun' wrote:
>> From: Guanjun <guanjun@linux.alibaba.com>
>> Fix incorrect descriptions for the GRPCFG register which has three
>> sub-registers (GRPWQCFG, GRPENGCFG and GRPFLGCFG).
>> No functional changes
>> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Should I send v4 to add your reviewed-by? Or you will add it when you queue it up.

Thanks,
Guanjun

> 
> Thanks.
> 
> -Fenghua

