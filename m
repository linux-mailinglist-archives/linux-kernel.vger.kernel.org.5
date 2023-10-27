Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C167D93A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjJ0J04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0J0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:26:52 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DDBAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:26:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vv-c.Z0_1698398805;
Received: from 30.221.128.176(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vv-c.Z0_1698398805)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 17:26:46 +0800
Message-ID: <1095973e-3577-40bf-23da-725f936a11ad@linux.alibaba.com>
Date:   Fri, 27 Oct 2023 17:26:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ocfs2: Fix a spelling typo in comment
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, jlbec@evilplan.org,
        mark@fasheh.com, akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kunwu.chan@hotmail.com
References: <20231025072906.14285-1-chentao@kylinos.cn>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20231025072906.14285-1-chentao@kylinos.cn>
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



On 10/25/23 3:29 PM, Kunwu Chan wrote:
> fix a spelling typo in comment.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index 6cb919f60011..cdb9b9bdea1f 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -345,7 +345,7 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  				if (new_bh && bh) {
>  					/* If middle bh fails, let previous bh
>  					 * finish its read and then put it to
> -					 * aovoid bh leak
> +					 * avoid bh leak
>  					 */
>  					if (!buffer_jbd(bh))
>  						wait_on_buffer(bh);
