Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8602F7D671A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjJYJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjJYJk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFDCA6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB84FC433C9;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698226823;
        bh=M9v/QfcahXGt7MoCY/1fFrdWgi6pHX9v0Gl8MznBkCw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a3Ftm80KvXGnrQkLo0+8QENQajpG8aGNb+0Uk6uHqf6zvHFFcpdKy/FhPpw/cmf/i
         6WyFWVugcKP2X9tn77tlluBQzg9KAsIaNeohAaGD2hI5/BSshamLvHJgQ0LG+WtUSY
         hdaETBLdOiNXPbbwIsAOXB0Ek7QepmgOBTx9t18ytImZnMZJMicNNTrRYNesrDiLrV
         8PrI9rAHOVnz69trQoaJAtvBvi/8lh29bT733mFr1Xpq/CKWwuReJGBD5XFFa+jV3v
         S31krZfQWLsXnmfbliLwYDi91C1TUn40qFlY2QlhlccgljDLXI5A8x6XO/uA6VxGjZ
         G10v+zR+XHzcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95E29E11F57;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv6: fix typo in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169822682360.18837.1022880287063370632.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 09:40:23 +0000
References: <20231025061656.2149-1-wangdeming@inspur.com>
In-Reply-To: <20231025061656.2149-1-wangdeming@inspur.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Oct 2023 02:16:56 -0400 you wrote:
> The word "advertize" should be replaced by "advertise".
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  net/ipv6/esp6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ipv6: fix typo in comments
    https://git.kernel.org/netdev/net/c/1711435e3e67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


