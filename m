Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DA77D1A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJUAu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJUAu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B2D7;
        Fri, 20 Oct 2023 17:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237EFC43391;
        Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697849425;
        bh=SwiIL60cYIwdT8Bj6HUQulAcBc0qTcFgAnVCGEwyHE8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MxeK5Y0q9299Rt6SDxxY3fYO5ntEqaEvhhvvUtauaSB4T+vGVWmCLH7zAmPeXIu8D
         SYeV8jNbmWuj1iW/djy+/ikwi2dpEIpObgRrBV2Ue/hyQSMv0B9f8QseMx7EvYUQjg
         UuPb56GGUFUV2NLA4T04ZkemIJwrA8G3q0fXao7H9sIFfv3Yc1+WwsdQrSwDaUCGzG
         w7pMmq7yUhnxHOeg9SJ3hLfknup9+r62HjS5YkICIN7IRBjGty/BLbGAN05NhNRnMO
         8Ug+iZrcXqAh+4TUq7rps9b83AeWBaLB8CscV9/BKzlytAtHrzBGbjxzRULmK4yGyK
         n4/y3Vf98Kktw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CFBDC595D7;
        Sat, 21 Oct 2023 00:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] pds_core: add an error code check in pdsc_dl_info_get
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169784942504.14403.3244794654825339187.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 00:50:25 +0000
References: <20231019083351.1526484-1-suhui@nfschina.com>
In-Reply-To: <20231019083351.1526484-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 16:33:52 +0800 you wrote:
> check the value of 'ret' after call 'devlink_info_version_stored_put'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/amd/pds_core/devlink.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - pds_core: add an error code check in pdsc_dl_info_get
    https://git.kernel.org/netdev/net-next/c/a1e4c334cbc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


