Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768F7660B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjG1AU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjG1AUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA3269E;
        Thu, 27 Jul 2023 17:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A992661F99;
        Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 100C0C433D9;
        Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690503621;
        bh=r/6uOjuf+8jNeeGqAD02WhCCOf2Al94cddsqK3FFU9Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tRIawUj0UTrfi29fx4N2OcqGZQqexbjxn1G9b4UPsY9BlMrtEvi/1N9g9In6Qc+lL
         NN9IB/WF1qzGxyvWhK8cL7WpgGepyjs6nxmkOtmof9EY/25hCvk20/xi5L2iSNrKfX
         aeUK+0vpOdZQJWXGUDkpk5FlcgotSufXBmGsHu6kXXtJsZFhHs5lH1/WVa//BvQyZ8
         L6ECsomIHk6c0CsnxGrr9BYFnAySGT7MI0ubQq/qhgOBp8Npn2bzuZc9De/Z4U2m+i
         rHKuFoLkRQpHkgjiY0+RPhrIT5H+5eNUr4PAopbwKEwPlr+MhrfCaIHcckj/UgjNhf
         f/JfjUOGI/QMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECCFCC64459;
        Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dccp: Remove unused declaration
 dccp_feat_initialise_sysctls()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050362096.24970.7000722732893710320.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726143239.9904-1-yuehaibing@huawei.com>
In-Reply-To: <20230726143239.9904-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, 26 Jul 2023 22:32:39 +0800 you wrote:
> This is never used, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/dccp/feat.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] dccp: Remove unused declaration dccp_feat_initialise_sysctls()
    https://git.kernel.org/netdev/net-next/c/d4a80cc69aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


