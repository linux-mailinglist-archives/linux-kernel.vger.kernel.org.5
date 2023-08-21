Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1106F7822BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjHUEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjHUEW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:22:27 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D4A2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:22:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vq9jX1I_1692591740;
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vq9jX1I_1692591740)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 12:22:21 +0800
Message-ID: <3a107c60-532a-dbc9-d899-40cfcaf9327a@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 12:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [v2] erofs: don't warn dedupe and fragments features anymore
To:     sunshijie <sunshijie@xiaomi.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230821041737.2673401-1-sunshijie@xiaomi.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230821041737.2673401-1-sunshijie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The subject should be:
[PATCH v2] erofs: don't warn dedupe and fragments features anymore

but it's not really needed to resend.

On 2023/8/21 12:17, sunshijie wrote:
> The `dedupe` and `fragments` features have been merged for a year.  They are
> mostly stable now.
> 
> Signed-off-by: sunshijie <sunshijie@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
