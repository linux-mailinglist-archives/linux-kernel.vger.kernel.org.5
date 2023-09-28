Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949797B152B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjI1Hkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjI1Hk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950C92
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E04C433CA;
        Thu, 28 Sep 2023 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695886824;
        bh=pjqPuAcv283NJ+TTvlNQXtbmZPqANr6CrDjBHJ/KfnY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T6649gcgKr76DAgluac1RhPWkNH/YnWbRi1O3EJTCHk7+/de9yncQV36OOqLVVJhZ
         Alcu50t3hIMxfo/Pzj+hWn0jycBiRrNLPnfbcUyqLBhUy26ZNMoZ21yyIDoAtrfTP5
         odoKL+kw189JSjvOro9botquGe6E/E4tYSrTadibwfqiKVFSuH0LQt3vvhH0zOPR3Q
         L7VKNAKKA7YX7anLeZXffIdzR42GLO5HDwoSi9adnCe+znOQH8folYRZkr6a18rQul
         bDAu2jea33cjv0LH4piKqZSzUr+L6atBUsAJZ/GPSS140pTk/CQiMD9NaLNEB0F3zB
         piIRfFGrJ0qDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DD6FC395E0;
        Thu, 28 Sep 2023 07:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169588682431.24360.15438983222452175812.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Sep 2023 07:40:24 +0000
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
In-Reply-To: <20230919124720.8210-1-ansuelsmth@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Sep 2023 14:47:20 +0200 you wrote:
> Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> NRZ in their EEPROM.
> 
> The module also require the ignore tx fault fixup similar to Huawei MA5671A
> as it gets disabled on error messages with serial redirection enabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
    https://git.kernel.org/netdev/net-next/c/d387e34fec40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


