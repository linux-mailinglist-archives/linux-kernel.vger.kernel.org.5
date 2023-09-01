Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF627900AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjIAQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbjIAQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:25:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840A410F0;
        Fri,  1 Sep 2023 09:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14DDDB82453;
        Fri,  1 Sep 2023 16:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9098C433CC;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693585515;
        bh=U7IcSk/+Nrzcif5ILllS7Sx3cRSaNGCvHPdUJRmgY+w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tEnq995I/E3nhH0Vvgt1lnUVTT8v5KvhEBpPcEWSpW1hVSH7BoJ1M9We0E2xS8bUL
         /mRueoBjj1C2ldNAdN3yeOWC16n3vrrHHh45USxIddXNCaxarxcKVJbcp/nRvPkl1H
         l8ZjUIdp7ChBareTmPru39tCMSZYmqPWQcr3D2a1c9TtBAT+MGxyM/1Mds3P4kPlTI
         drL1mh/UkVCTkcXZntW6goWBhHIijQcwkn64ub07M8fXp70Hb+BJ24TzWup/BzyMi4
         OJfQyaQ+Bl/+HloCd/PBzOY1F/yp0H4sIFORWZRwX9miCS3apfUJEwq+qL3b0evo5Q
         dHGxPMpdc0Cug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E5CBE29F3D;
        Fri,  1 Sep 2023 16:25:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: dts: allwinner: d1: Add CAN controller nodes
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169358551557.8276.8875001900828239804.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Sep 2023 16:25:15 +0000
References: <20230807191952.2019208-1-contact@jookia.org>
In-Reply-To: <20230807191952.2019208-1-contact@jookia.org>
To:     John Watts <contact@jookia.org>
Cc:     linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        aou@eecs.berkeley.edu, samuel@sholland.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        wens@csie.org, robh+dt@kernel.org, palmer@dabbelt.com,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        bigunclemax@gmail.com, mkl@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
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

This patch was applied to riscv/linux.git (fixes)
by Chen-Yu Tsai <wens@csie.org>:

On Tue,  8 Aug 2023 05:19:52 +1000 you wrote:
> The Allwinner D1, T113 provide two CAN controllers that are variants
> of the R40 controller.
> 
> I have tested support for these controllers on two boards:
> 
> - A Lichee Panel RV 86 Panel running a D1 chip
> - A Mango Pi MQ Dual running a T113-s3 chip
> 
> [...]

Here is the summary with links:
  - [v3] riscv: dts: allwinner: d1: Add CAN controller nodes
    https://git.kernel.org/riscv/c/f05af44f6913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


