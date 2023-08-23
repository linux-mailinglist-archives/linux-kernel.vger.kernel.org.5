Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA497785C07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjHWPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjHWPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7CCFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ABB1612E7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0828CC433C8;
        Wed, 23 Aug 2023 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692804333;
        bh=KEPHfyKB9dhGJ6q8QlmUUhxO7CUxAWlkhe1aFTi9XcQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kfWflLKZYqhdg+s6/ycK27d0p+oNcB1h/hTqSIm57KWJxLyvQRoFK9tWA/AlT9phR
         MNT1h2Cxah1tZSgSLSVuZ+DQ5q4F6cymQDKP/xn4EoJ0giKhDm7382G2Qpm7lkc8se
         aKRGIjm9ryTmpr1VvUDPGuAXqEFtYhCiu4F0Nbh4m2Av+ub4lmOytVGdIfv1ob5Y/y
         lpGd6G5j7wgleoKIy9jpmepvB5kQBYs3JVza9TOPrS5xf45esr70TqhasqXBM3gFJP
         omDtKQJEygyNpfK3JqTessFvHCfs4j3Elba+pPgrGvFZ81F2aOfdVZXox7yRQxNU6m
         O7ZNqBKWbVCzQ==
Message-ID: <90280d3c-c3d0-0ef0-3a75-97b609fd4299@kernel.org>
Date:   Wed, 23 Aug 2023 23:25:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2] erofs: don't warn dedupe and fragments features anymore
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        sunshijie <sunshijie@xiaomi.com>, xiang@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230821041737.2673401-1-sunshijie@xiaomi.com>
 <3a107c60-532a-dbc9-d899-40cfcaf9327a@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <3a107c60-532a-dbc9-d899-40cfcaf9327a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/21 12:22, Gao Xiang wrote:
> 
> The subject should be:
> [PATCH v2] erofs: don't warn dedupe and fragments features anymore
> 
> but it's not really needed to resend.
> 
> On 2023/8/21 12:17, sunshijie wrote:
>> The `dedupe` and `fragments` features have been merged for a year.  They are
>> mostly stable now.
>>
>> Signed-off-by: sunshijie <sunshijie@xiaomi.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
