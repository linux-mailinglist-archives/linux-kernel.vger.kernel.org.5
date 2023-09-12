Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD19179C9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjILIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjILIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:30:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B3210D7;
        Tue, 12 Sep 2023 01:30:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 960EAC433CA;
        Tue, 12 Sep 2023 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694507430;
        bh=s2uBgeRSuYe5cJdnSbgRNcVkNm/cSXAA6GCrs5EOgts=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=riyxw6UVa0dZ+CFqIsmyv4qYDkyaXlzlHw7U0rUzAkUW38l92CCw256LbzZrYEGaM
         AoomPN9Waic+Td+3NEiPIYwXGz54dT5Bvp6G13/FzqgBxHGOrxttCKBSVqTNy0ehU9
         peaP2roDGO4keZnbKvH2bKL9+BPRczCvrs0rsvoUZzhfkte4oecMII4hTqWv6ajUSs
         QYdAns7dxQwRYpRz8acRvu+X5De5H7IQdvAgkCbPDDiTBUU6pIexnUuJ1YzZMAZJIz
         3QHWM8tAxoXGgaHUwMj9LYer30HXUkCMpdI5BGvk8PRDHJ+xPGLCj5ozdYY2VYm4Qv
         iuN9hTUNvPNwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 768A2E1C282;
        Tue, 12 Sep 2023 08:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Add support for ICSSG on AM64x EVM
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169450743048.32515.14715213630725008702.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 08:30:30 +0000
References: <20230911054308.2163076-1-danishanwar@ti.com>
In-Reply-To: <20230911054308.2163076-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     andrew@lunn.ch, rogerq@ti.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, vigneshr@ti.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 11:13:06 +0530 you wrote:
> This series adds support for ICSSG driver on AM64x EVM.
> 
> First patch of the series adds compatible for AM64x EVM in icssg-prueth
> dt binding. Second patch adds support for AM64x compatible in the ICSSG
> driver.
> 
> This series addresses comments on [v1] (which was posted as RFC).
> This series is based on the latest net-next/main. This series has no
> dependency.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: net: Add compatible for AM64x in ICSSG
    https://git.kernel.org/netdev/net-next/c/0caab0a46d06
  - [net-next,v2,2/2] net: ti: icssg-prueth: Add AM64x icssg support
    https://git.kernel.org/netdev/net-next/c/b256e13378a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


