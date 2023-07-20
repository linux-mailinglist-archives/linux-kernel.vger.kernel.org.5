Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1975A4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGTEAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGTEAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAA1FED;
        Wed, 19 Jul 2023 21:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E9D615B3;
        Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EB8BC433CA;
        Thu, 20 Jul 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689825622;
        bh=Asw33ccJGt+82XG4DwTLLFE/7jX9zPKbdust7yp+7zo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T82iKtVh2/i6QbhxfzzhypcrFBwq6I4+pUDf3qD4BugGzMEhLOFAkh4XuryqIaHKO
         5PtMH/12pLabp95FXlLv6ixoT4Wx2Cp50Yx+cONhno+Jv1CrpuEKbiznlhKFYrnTmM
         6pBIhUbrzNTVF/Te3c5vQy0X1IXp6XQ4o6HoYAG2WLWU6jZpfqAPzEbVSK2LDBbQhl
         ChnIIS7mPDVdGdhB+1/fN5SDnsTzmcQlBfVtHS0fTbVH5K/CCTDb7SpnVgRvQkYWZ2
         kpNrr6hF3zHDc5lMfM6NNb1bAMEer1Bvqwze3pLlCKaxuifl1sYf138y9DpNc+e1wN
         UEZgA+dPKQ1sA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDB11E21EFE;
        Thu, 20 Jul 2023 04:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: rockchip-dwmac: add default 'input' for
 clock_in_out
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168982562196.4243.14007279822210402667.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 04:00:21 +0000
References: <20230718090914.282293-1-eugen.hristev@collabora.com>
In-Reply-To: <20230718090914.282293-1-eugen.hristev@collabora.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, david.wu@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jul 2023 12:09:14 +0300 you wrote:
> 'clock_in_out' property is optional, and it can be one of two enums.
> The binding does not specify what is the behavior when the property is
> missing altogether.
> Hence, add a default value that the driver can use.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: rockchip-dwmac: add default 'input' for clock_in_out
    https://git.kernel.org/netdev/net-next/c/51318bf44395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


