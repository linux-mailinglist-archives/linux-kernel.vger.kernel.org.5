Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC37660B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjG1AU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjG1AUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58B268B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB1661F88
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02D7BC433CD;
        Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690503621;
        bh=JWpibV1AQXBMpPFvCewoBsCPhbnapxlbGt4HsLNitJo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cjsALfXyWA/6raCCl2px6oP9dHVI0H2lgfOOk0OgMkuMP5SgQggtxyRMFs+YHPDfp
         eEZR/KZdnLWiGaq56v2krh/Zj42BbLex/0ual0lDgI3DpqUrp8wSTgM5qWVrHT3yOG
         /eCUgIboNAuzcV8lTNA2NHthDvx5w0CaPWwEKI764J69oc7VJdZDSkCtt0h7XyvGZH
         A2Rq5fIuC/cER0EdPG5kV2jg2g8//gBIjNdYHL7hv7CkKbfMeT/diR+6gUwQ6c6qNs
         OddxVh7qRQnAilLi3WA++CpbLsNBOezNc1461qpd3FwrwftjG25y4ulzPBuRGm/Lfm
         yo0cOqsMs/1Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3C40C41672;
        Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: Remove unused declaration
 br_multicast_set_hash_max()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050362092.24970.6426041238367256548.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726143141.11704-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143141.11704-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        idosch@nvidia.com, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:31:41 +0800 you wrote:
> Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
> this is not used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bridge/br_private.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] bridge: Remove unused declaration br_multicast_set_hash_max()
    https://git.kernel.org/netdev/net-next/c/4d66f235c790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


