Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7E7BC280
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJFWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJFWuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:50:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF19F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:50:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA2F3C433CA;
        Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632631;
        bh=lFVMZxrxgu2mLgsdaQIPMtturFqWL5orwm6KDhXTac8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hr7RpFHUKyrGtlqnrBPn2DoWNvI0XCMUMMABXSwZUKAw/tkRP2Z0j0J+GNzwcDOKJ
         Lk74wJqtzN9LK635nTiTBx3vdqif4GSGj3A230O1NmMCkZLULCwplJsltKt8q2S7Ph
         o7p4wa7PJugL8xn7LrH5Jcb+LkP/YQc9VxTIx42vReiWTld1lCmYdI+4dueVZFleYH
         YcQt6arP52gQ3zDlNy3K3CuVs3ERn7kV8XrwzezHWeQ7SyGQO3cOvtN7i2yji37imz
         5HbAfqxWaISX/b69CMmk8h4vWXQD1Xssl3Y9cixgEKyW7KAA0xegUbck8GC70WvRGn
         MLrZ9IOfUO9DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB9A1E632D2;
        Fri,  6 Oct 2023 22:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Update LL TEMAC entry to Orphan
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663263174.25368.668151367419972633.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 22:50:31 +0000
References: <20231005131039.25881-1-harini.katakam@amd.com>
In-Reply-To: <20231005131039.25881-1-harini.katakam@amd.com>
To:     Katakam@ci.codeaurora.org, Harini <harini.katakam@amd.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, esben@geanix.com, jsc@umbraculum.org,
        christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Oct 2023 18:40:39 +0530 you wrote:
> Since there's no alternate driver, change this entry from obsolete
> to orphan.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] MAINTAINERS: Update LL TEMAC entry to Orphan
    https://git.kernel.org/netdev/net-next/c/0ff85cb9ce66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


