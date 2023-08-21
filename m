Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17678227F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjHUEKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjHUEKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:10:33 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E740EFD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:09:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vq9jTDA_1692590934;
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vq9jTDA_1692590934)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 12:08:55 +0800
Message-ID: <d360c1d4-55c9-5d82-1bc8-9e3595e65ade@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 12:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs: don't warn dedupe and fragments features anymore
To:     sunshijie <sunshijie@xiaomi.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230821040430.2673259-1-sunshijie@xiaomi.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230821040430.2673259-1-sunshijie@xiaomi.com>
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



On 2023/8/21 12:04, sunshijie wrote:
> The dedupe and fragments features has been merged for a year, it has been mostly
> stable now.

some grammer fix:

The `dedupe` and `fragments` features have been merged for a year.  They are
mostly stable now.

Thanks,
Gao Xiang
