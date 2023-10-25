Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109A47D6719
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjJYJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjJYJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3DA1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE601C433C8;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698226823;
        bh=obLZ+ov0IDqSzA8P6SKqhzYX3GlFGhhfWdc5m4TasUI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XeHouFxs7/tc/dnttJDfuLetS3FoZITsAvxuv183v+Mq2wwpYyiAxe7EJ6fICw2p9
         rnb6BnZeVV85w36CZmHjzRDu4hgMbexWaHmq8nP4tplAcilxX5w8d/TKt90h1mP32d
         zHSaxK90Obz/O0d+KvNyCSQubh8NXcvSdLG2pInlkCxgI24RAWqPSSxVXyAMwkGA6B
         O8z0YNRxq9FekI7c4aZFQ0pUylSbsAjxcY1o6Q4ToVVPoTS0RAmM54DmC4bvmyrNsC
         lKmKnXMb2te84cgFF9K7VwlpBZ+EiQZ6mBknV1C9Lgd7P7ls39twP05Be1c2T7FlAx
         sBqS6zR3vR/lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C8D6E11F55;
        Wed, 25 Oct 2023 09:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipv4: fix typo in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169822682363.18837.12374680836954385910.git-patchwork-notify@kernel.org>
Date:   Wed, 25 Oct 2023 09:40:23 +0000
References: <20231025061434.2039-1-wangdeming@inspur.com>
In-Reply-To: <20231025061434.2039-1-wangdeming@inspur.com>
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

On Wed, 25 Oct 2023 02:14:34 -0400 you wrote:
> The word "advertize" should be replaced by "advertise".
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  net/ipv4/esp4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: ipv4: fix typo in comments
    https://git.kernel.org/netdev/net/c/197f9fba9663

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


