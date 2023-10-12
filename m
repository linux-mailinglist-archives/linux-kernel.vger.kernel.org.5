Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE907C6216
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjJLBLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:11:31 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08280A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:11:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VtyLKrJ_1697073085;
Received: from 30.221.128.69(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VtyLKrJ_1697073085)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 09:11:26 +0800
Message-ID: <6378684c-08a4-778c-e13b-7162cc26e31d@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 09:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ocfs2: fix a typo in a comment
Content-Language: en-US
To:     Yuanheng Zhang <yuanhengzhang1214@gmail.com>, mark@fasheh.com,
        akpm <akpm@linux-foundation.org>
Cc:     jlbec@evilplan.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231011163216.29446-1-yuanhengzhang1214@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20231011163216.29446-1-yuanhengzhang1214@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 12:32 AM, Yuanheng Zhang wrote:
> Fix spelling typo in comment.
> 
> Signed-off-by: Yuanheng Zhang <yuanhengzhang1214@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index 196638a22b48..6cb919f60011 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -158,7 +158,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
>  			if (new_bh && bh) {
>  				/* If middle bh fails, let previous bh
>  				 * finish its read and then put it to
> -				 * aovoid bh leak
> +				 * avoid bh leak
>  				 */
>  				if (!buffer_jbd(bh))
>  					wait_on_buffer(bh);
