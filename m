Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FB7A67A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjISPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjISPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7994;
        Tue, 19 Sep 2023 08:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44B02C433C9;
        Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695136222;
        bh=wrqC6REkEJrkRzfwAscQTd/GQ3EwDBjwa+nBdT4zorE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hRZBH2mRC+9x0jnRcoJj/8vSiEbpNPMMVLx+2BRpC36iWRIP0c/814EkbSSEd4WEP
         r3iJ0aI4ZMVAXGMMTqoTKj4Uy73IGK0ZQWfmUbIKpbCgmm18Q5oDCx0VwDvNS6bHZi
         djewUojBorSM0g1Lfr+9QFFi0tXFlRbSyZi2jPiomWVpSmkyAV/tb37GmEui/oBjwz
         c5FICpWs+CU9qV3LlvZl/IPBTzeieMc7lSj8ZPisRuqCe8HyFcomZ7+N61dEzSeTjr
         jgByjGxT6+cC1QxM35NvM6Qgq4/qYO0QSU+Ycqh5jO9Ek8NxEQViKpLgf9sZ0mdsrE
         hlUNrWCXeGvRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27214E11F41;
        Tue, 19 Sep 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: dsa: microchip: Fix spelling mistake "unxpexted"
 -> "unexpected"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169513622215.19882.9342395230402169534.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Sep 2023 15:10:22 +0000
References: <20230918132142.199638-1-colin.i.king@gmail.com>
In-Reply-To: <20230918132142.199638-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, 18 Sep 2023 14:21:42 +0100 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz9477_acl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: dsa: microchip: Fix spelling mistake "unxpexted" -> "unexpected"
    https://git.kernel.org/netdev/net-next/c/1964aacfaed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


