Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7297BC370
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjJGBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjJGBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E826BD;
        Fri,  6 Oct 2023 18:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEB40C433C8;
        Sat,  7 Oct 2023 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696640423;
        bh=NEqHBe+eX7OIDPmmjjD/TBY6CeK3+9IHwSncD+p1M4s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QFiaSqXkVqWALVSRNzn2GDbFcJC+WebIruWduuxNJD4VSWK7FLri/04tdsLx5onGo
         18IykfxGDDdNyxbgPnGwjTqAHClNJlkuRzegYTzT77havYer20gy/0BJIJBR2TzSdr
         q27cAZOA60dm21IiFqO4s4PObIyeIR8LyFX3cvY97fiToAyF54BoRwNQRJqaZ6OtZO
         yEx6GEKpb2L3Uop3dUH2QoM+J15ceMWk3ga86tvZ2c7Dte7MnZOsym83RlO/OV18oL
         RB4VV79wZKOcIX/lVHrTsuwvX2q2feB9sURgOF9lkOdxL0wYqRttab1SERScACdtL7
         CIDNHdSSmXIJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E00C41671;
        Sat,  7 Oct 2023 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Ignore error return for
 hci_devcd_register()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169664042379.23949.8315443049400174883.git-patchwork-notify@kernel.org>
Date:   Sat, 07 Oct 2023 01:00:23 +0000
References: <20231006024707.413349-1-max.chou@realtek.com>
In-Reply-To: <20231006024707.413349-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com,
        regressions@lists.linux.dev, kirill@shutemov.name,
        bagasdotme@gmail.com, linux@leemhuis.info
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 6 Oct 2023 10:47:07 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> If CONFIG_DEV_COREDUMP was not set, it would return -EOPNOTSUPP for
> hci_devcd_register().
> In this commit, ignore error return for hci_devcd_register().
> Otherwise Bluetooth initialization will be failed.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Ignore error return for hci_devcd_register()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3ef20de6b2a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


