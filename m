Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E980EA41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbjLLLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346233AbjLLLUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95930F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:20:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31C17C433C9;
        Tue, 12 Dec 2023 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702380023;
        bh=3W/bEs3dAdW0mWyW89QI4cQo0ioFIjOBKCJ67cxj9P8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nd6a7yP7OrlsARfcJRcp27W9BCSGlhix8T1Wuf9Cc8ONuU/9DFUlWJ0BsRsHa9wzS
         ujlABDtE18KHPN6SDvx9EodOHwJU0/O9Ssm3gOMos4dbRLjxpuZOIqPLGFcJAGqiP5
         B62DnhWXB3qKlxxYwcOq+WU4mAAqh8k8gSb7LqynAF95Q1a7ORGantQ8Cx4Zm8OfBT
         rh8bABBzfwkGQrYiGxiIYjiC4V7D7JVzUVJ8Eh8pRuUDWP8752oZAph9KnIllFzvuC
         ZpkfsB5Y9eCPIl0SK+4uTdc1oy6siVjOsHIAp3O6kDxya5ejXS7wOcdVscO9xj/oS1
         2CdaH5fsecVIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15499C04E32;
        Tue, 12 Dec 2023 11:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dns_resolver: the module is called dns_resolver, not
 dnsresolver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170238002308.1536.14490609538387785726.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Dec 2023 11:20:23 +0000
References: <gh4sxphjxbo56n2spgmc66vtazyxgiehpmv5f2gkvgicy6f4rs@tarta.nabijaczleweli.xyz>
In-Reply-To: <gh4sxphjxbo56n2spgmc66vtazyxgiehpmv5f2gkvgicy6f4rs@tarta.nabijaczleweli.xyz>
To:     =?utf-8?q?Ahelenia_Ziemia=C5=84ska_=3Cnabijaczleweli=40nabijaczleweli=2Exyz?=@ci.codeaurora.org,
        =?utf-8?q?=3E?=@ci.codeaurora.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 8 Dec 2023 21:16:12 +0100 you wrote:
> $ modinfo dnsresolver dns_resolver | grep name
> modinfo: ERROR: Module dnsresolver not found.
> filename: /lib/modules/6.1.0-9-amd64/kernel/net/dns_resolver/dns_resolver.ko
> name:     dns_resolver
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> 
> [...]

Here is the summary with links:
  - net: dns_resolver: the module is called dns_resolver, not dnsresolver
    https://git.kernel.org/netdev/net-next/c/26c79ec96e77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


