Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5F76CB45
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjHBKub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjHBKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984B6127
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 245626192D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77599C433CA;
        Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690973422;
        bh=59ysNhABi4us3vvJSqXrfPwM766CiEebPgaHbS/7DnE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nUE5N91JoB3NaNaxWeJw8xClD/334A9y7TH9NqCnPyQI9xqBOKxZB/dbfqfOCvfz8
         e0NAVAwvrva7I1HlF+f4KxdMrEG56AUPvHxtWF2PalOGAZRwaa7iQfsqng2BNbV2kT
         QYZXvzwj/v/U/y2odtXOhQJ1w5SYRl9C1p3pyg8H8WNxbHdAYqS6bJiT04fUWkgKWq
         3DixT/2ha7y9Nhz5tSyY1+VQ5bQgeFQTeHTJ8HTAXLD4VuF8FSV26WyBOEjGSLLnG0
         n0TYJcOTtVzYckl75Vt/KyiBZ1MMoMhLcmFN8JzPMDgTUlfoplmE8Ig3/+4oCM2lIF
         DFxI7Ddr5aHfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BC79C691E4;
        Wed,  2 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: fman: Remove duplicated include in mac.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169097342237.23292.2254772671647186328.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 10:50:22 +0000
References: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230802005639.88395-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        sean.anderson@seco.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, abaci@linux.alibaba.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Aug 2023 08:56:39 +0800 you wrote:
> ./drivers/net/ethernet/freescale/fman/mac.c: linux/of_platform.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6039
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: fman: Remove duplicated include in mac.c
    https://git.kernel.org/netdev/net-next/c/34093c9fa05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


