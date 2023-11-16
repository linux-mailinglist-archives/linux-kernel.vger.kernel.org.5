Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714507EE92B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjKPWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C2C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D227C433C9;
        Thu, 16 Nov 2023 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700173224;
        bh=y2tdWV5+WM4fXRfgOiOyz6S5uMTan+kf+sRDuHkILNc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cgvP4NMYXNMYwLpdHQo5EDFmgE+kc9nQeZd+dnVGoj5wNaoIdeloWt93CbBvlAwWT
         zWzTsKVuHTa8ZK1VZQuMOVjJ550LTERG6sS7OJzGzElf511l3qP5g2cN85U1w5Y6g8
         MlRBMqzCtThejQbWXHSjasdtLAKBn+Qd9qEfZ7Mudtd6XOnrs+Dyx1hN7kJDf/McBr
         XY1GC6NFCRFmav5gV6Xh5Q9vrv5qY57ySWC8rkBnlQgePvSFlj+HaiyYKfNUQq141f
         ch//shzHr1ohw9ze2jlE7vGwW7JdlaeUXX46R2gtH5VUQU25gafcOdOotaBEaTaOnc
         R9ctE5z4PmJKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40851C395F0;
        Thu, 16 Nov 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v8 1/4] net: phy: aquantia: move to separate
 directory
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170017322426.10772.15208899702041865337.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 22:20:24 +0000
References: <20231114140844.9596-1-ansuelsmth@gmail.com>
In-Reply-To: <20231114140844.9596-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robimarko@gmail.com, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 15:08:41 +0100 you wrote:
> Move aquantia PHY driver to separate driectory in preparation for
> firmware loading support to keep things tidy.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes v8:
> - Out of RFC
> Changes v7:
> - Add Reviewed-by tag
> Changes v4:
> - Keep order for kconfig config
> Changes v3:
> - Add this patch
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] net: phy: aquantia: move to separate directory
    https://git.kernel.org/netdev/net-next/c/d2213db3f49b
  - [net-next,v8,2/4] net: phy: aquantia: move MMD_VEND define to header
    https://git.kernel.org/netdev/net-next/c/e1fbfa4a995d
  - [net-next,v8,3/4] net: phy: aquantia: add firmware load support
    https://git.kernel.org/netdev/net-next/c/e93984ebc1c8
  - [net-next,v8,4/4] dt-bindings: Document Marvell Aquantia PHY
    https://git.kernel.org/netdev/net-next/c/0fbe92b9fd4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


