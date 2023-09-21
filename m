Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAF7AA036
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjIUUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjIUUd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:33:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563FB8611B;
        Thu, 21 Sep 2023 10:37:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D48E3C4E755;
        Thu, 21 Sep 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306022;
        bh=WBpt0UJgzXAKDLTjwPscCIHs+G2g2Gy4mXrkc6WDOS0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lHqMUpxmk5mzil1T6dqxSSOJlWKcVRpUK8QUxua1r0kiQ+SZc1wl4wKlv4nKHq0ck
         c+6j+wOlgtH5dD9c/nseoxc8LU3h/yDzzHyG8TmLYpRXe5MxrtODaM0/0aBMjNHgpY
         lBo3J3B/3sOr6x74f/G3NWvaeycU2wBMt6JKqe7m3vPSxKaqCJrezzQETdGAmNNAb8
         J0eH5q3okKfdo1vzxaDBmS86uJIExByXI/0/uW9V3qB+YXARn4Sj8e+m8+iFTS+Atd
         ZOLUheqv97C7IAytIG+GQeyWh2beqrNv+YOfAV0sozERVbsQvPhyANp6/3LFcB5hnj
         tcBqePEeoLO6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA84DC04DD9;
        Thu, 21 Sep 2023 14:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: sja1105: make read-only const arrays static
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169530602276.5007.573256202106314126.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Sep 2023 14:20:22 +0000
References: <20230919093606.24446-1-colin.i.king@gmail.com>
In-Reply-To: <20230919093606.24446-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     olteanv@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 10:36:06 +0100 you wrote:
> Don't populate read-only const arrays on the stack, instead make them
> static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_clocking.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [next] net: dsa: sja1105: make read-only const arrays static
    https://git.kernel.org/netdev/net-next/c/f30e5323a188

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


