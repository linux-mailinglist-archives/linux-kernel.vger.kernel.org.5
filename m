Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEDA78A57B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjH1GAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjH1GA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469E122;
        Sun, 27 Aug 2023 23:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF45861EDB;
        Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34FF3C43391;
        Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693202423;
        bh=M8CVt/akAcg3m+yLAHAXXHxbfvJpt0JVg7QP00pVJTM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HNSERr3rpLPz8SnhG4G5/mQksghoqgKRCteSDqF4pTSuRYBvrPjXNdAE2dfqJKSmi
         lyPscdCBcOXxjrB8VztbF7q1CbYYDSo5LvaVT17Ds1DmieucSkD66SkIlm65N2O6bQ
         4HBCpU07mj6RqgcdcHW3+6eo7+hjcNzzL2ODMBUBtK8ansKcO6oUnC7VkLKoVaYwgH
         lf6zKsjEK+2Py3/KUsRTdwlaKREhd3b3cJg0F31OPiMvlYdjlhgUCq0usYS2/4dVoB
         RGGmr+hs4oeWLxVVaDVft74yumhzQl04LhTdG1L/Yud9KPIIbkycNAWxotA/YqV0Ay
         FZwcEirU0WvDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EE35C3959E;
        Mon, 28 Aug 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] dt-bindings: net: xilinx_gmii2rgmii: Convert to
 json schema
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169320242312.13305.11528710657423623934.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 06:00:23 +0000
References: <20230824114456.12243-1-harini.katakam@amd.com>
In-Reply-To: <20230824114456.12243-1-harini.katakam@amd.com>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 17:14:56 +0530 you wrote:
> From: Pranavi Somisetty <pranavi.somisetty@amd.com>
> 
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] dt-bindings: net: xilinx_gmii2rgmii: Convert to json schema
    https://git.kernel.org/netdev/net-next/c/c639a708a0b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


