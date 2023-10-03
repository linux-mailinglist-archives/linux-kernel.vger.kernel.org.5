Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523D57B6618
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbjJCKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17066A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD33C433C8;
        Tue,  3 Oct 2023 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696327825;
        bh=uXqJyKIEjoRjDoUyS9dLAC8UnkEHjOxuTUIcvQjD/x0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Gde5yY8GdNxo/cFr8EPOZtRU43fyfBC4BHFflrxiwW0CubZ6hwrL6huhPjjlRvboZ
         4gxuByUDdNyOcxgE0hRrpciZsHktKTqzVhA9A0QT/TdkttDMSS808iD65A8vzDADrn
         tqEO2aH7+VaxNjBf4hzavYFEFJK/89NMJi4iAFDN/efiF4HM24wTGNgYJ0zdOSZg3A
         Vq+a05tFGycY6Jgo9OjQfPE2wbJluxt0x1Aob62CHKB3X8xrLs629PbG2FeH9xVgp+
         E9/EJMZa1GXqvudVzGl7BnAryi3BTKbCvW4m7koihQQ/25qL+qRfwQv9IAJhrQqONq
         m/3cN9C/67ihQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85312E632D1;
        Tue,  3 Oct 2023 10:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: mark address parameters of
 udp_tunnel6_xmit_skb() as const
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169632782553.9249.11688827949033557863.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 10:10:25 +0000
References: <20230924153014.786962-1-b.galvani@gmail.com>
In-Reply-To: <20230924153014.786962-1-b.galvani@gmail.com>
To:     Beniamino Galvani <b.galvani@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, gnault@redhat.com,
        linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 17:30:14 +0200 you wrote:
> The function doesn't modify the addresses passed as input, mark them
> as 'const' to make that clear.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  include/net/udp_tunnel.h  | 5 +++--
>  net/ipv6/ip6_udp_tunnel.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: mark address parameters of udp_tunnel6_xmit_skb() as const
    https://git.kernel.org/netdev/net-next/c/f25e621f5d4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


