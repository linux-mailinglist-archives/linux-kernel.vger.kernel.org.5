Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958C67B1FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjI1OgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjI1OgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:12 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DCFCC0;
        Thu, 28 Sep 2023 07:36:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vt1uLaf_1695911763;
Received: from 30.27.96.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vt1uLaf_1695911763)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 22:36:05 +0800
Message-ID: <a9f381bc-f2f1-d94c-8f4b-579f0bdd1506@linux.alibaba.com>
Date:   Thu, 28 Sep 2023 22:36:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] erofs: update documentation
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230928134852.31118-1-jefflexu@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230928134852.31118-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 21:48, Jingbo Xu wrote:
>   - update new features like bloom filter and DEFLATE.
> 
>   - add documentation for the long xattr name prefixes, which was
>     landed upstream since v6.4.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
