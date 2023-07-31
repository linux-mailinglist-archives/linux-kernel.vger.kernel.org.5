Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40BF76A355
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGaVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGaVu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B525171E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20834612FE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724C2C433C7;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690840222;
        bh=b7GuPhvW+caI+IgBWtWJ288PaFDgBloQho1XulayYdI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ol7eUez+aCTR8lYkr8Yoj5YdkJCqNqaJDaj9lBmx3+uy1iG6N6KqPlh2SZIXiofFi
         zkSq8i7oIbuMcbWmd0aT1hzav6Unend6SLdlX70LNc3b0utPOKnXruLZqBp1hxogHG
         +FyYQOJg4BhkwG/kinsFqrrXPFNJNREvYSLAo0Feym/w+scXvn+MfSZsXHHUTZLptH
         UpduFoeK/w8lHkJM1CN6pySgHkBojTEYhOr/E0uhMSdOgF0IHwrgwdXaebAoaw+f64
         +Evqmr+l6h6ROr40ERDC6BlCofwEMyoKAKtDIASvxm1InIvDQfmWQXDopNDB9picL4
         N0DLr0SKK0QAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CCBDE96ABF;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169084022230.13504.17004715594026718607.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:50:22 +0000
References: <20230729122036.32988-1-yuehaibing@huawei.com>
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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

On Sat, 29 Jul 2023 20:20:36 +0800 you wrote:
> These are never implemented since introduction in
> commit d021c344051a ("VSOCK: Introduce VM Sockets")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/vmw_vsock/vmci_transport.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] vsock: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/634e44971981

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


