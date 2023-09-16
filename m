Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881607A2F53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjIPKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjIPKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:50:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5714E3;
        Sat, 16 Sep 2023 03:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48FD8C43391;
        Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694861424;
        bh=QT2lWqyg+MtX/ZEh6qrZXyyEC1jXOKlLGV4I3Csj5p8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Cnw3hPoLHy5+H9pNocaiEkrHbnOrwWT8sE/94QhWxEI/lybZzLLnueZZGttuB6JpF
         GCGfuLTGtp9B+jeLR56LJQivqDsKaoy2ESOFpOijMbpzsb0bYB/62p0gTGAwgEXCUa
         scO0Pag6tRymrTZmIq+tywuyN6TCgJnwyA4Bw8pPk8tcfEkN7rgrHrcSKwXH7inf+A
         sNV/c6JZJsnYZWWPrzYvpXII0Q0MSdilNRDYY9vHkppmBXYaPGb92HUL64qzLT19u6
         yyydUT6rEkzwdALwNIC4D3Ae31w0SSoatTXmVFmZnHLUecvxBX2NGwP9nwDWiEj5ZC
         3bXTKBmTRAf0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33AF2E26883;
        Sat, 16 Sep 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169486142420.3496.7382362425660916712.git-patchwork-notify@kernel.org>
Date:   Sat, 16 Sep 2023 10:50:24 +0000
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
In-Reply-To: <20230914114435.481900-1-keguang.zhang@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tsbogend@alpha.franken.de,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, Sergey.Semin@baikalelectronics.ru
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 19:44:32 +0800 you wrote:
> In order to convert Loongson1 MAC platform devices to the devicetree
> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> Add dt-binding document and update MAINTAINERS file accordingly.
> 
> In other words, this patchset is a preparation for converting
> Loongson1 platform devices to devicetree.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
    https://git.kernel.org/netdev/net-next/c/7e10088bc4e4
  - [v5,2/3] dt-bindings: net: Add Loongson-1 Ethernet Controller
    https://git.kernel.org/netdev/net-next/c/2af21077fa9f
  - [v5,3/3] net: stmmac: Add glue layer for Loongson-1 SoC
    https://git.kernel.org/netdev/net-next/c/d301c66b35b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


