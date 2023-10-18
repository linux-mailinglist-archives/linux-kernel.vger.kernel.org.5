Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20487CE8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjJRUbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjJRUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:30:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4712B;
        Wed, 18 Oct 2023 13:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E4B2C433CA;
        Wed, 18 Oct 2023 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697661024;
        bh=P9A/X5s37ke3+Nv2Wh+UccKUBLUAL5edEf7VhXuM7oQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vLnHkwlif2dlA25Y5kNogc+b9K0Ji1yxdlKCNv08CUDN7VSnfJdmXx1pHtC+O6ib/
         if7iLM4gSvZe4oEviDVKmaCQGgxyKjh+bOyc6EnMYUZsxMHFXzxcdSRRtQs/wPJqLB
         r/5nyvvhMRkypjhe80ppOkl6cJL+1OfyoLYxfmWBTghOxvEfLfMxbdKrXK00icZvkS
         2vGX5rsJtugNLPSS05t5UERNCSAt/Pdl0RjPXW8GqZrgXyWHGajtWLB/wUd+54pyBd
         pKOGd9S7Uy8/TkzsK21dwq+GDSKuVaSALGDBlCdOsDacLm1QCM3BYtsGsnwlZ4O8mj
         aM+ZY/MIDu2IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74282C04DD9;
        Wed, 18 Oct 2023 20:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169766102447.20333.11792523121901366005.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 20:30:24 +0000
References: <20231018144735.33085-1-marcel@ziswiler.com>
In-Reply-To: <20231018144735.33085-1-marcel@ziswiler.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
        johan.hedberg@gmail.com, marcel.ziswiler@toradex.com
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

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Oct 2023 16:47:35 +0200 you wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Printed Opcodes may be missing leading zeros:
> 
> 	Bluetooth: hci0: Opcode 0x c03 failed: -110
> 
> Fix this by always printing leading zeros:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a589c6d138e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


