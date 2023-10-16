Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CD7CB179
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjJPRka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E49F;
        Mon, 16 Oct 2023 10:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 223EBC433C9;
        Mon, 16 Oct 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697478024;
        bh=YE8MV4L87LoXSPHfgHSpNYR3qUPuVdzDgJOEEjAyswk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PfGErQehjQbVq2zZa+DapTMGFT3uN7ex8slsbFQpJlOC/UFptAtmgzJW+sfcnIoTy
         FMrMfpdWBGXq0phQOMA+T/41V7kJ8YeDlFyzticwP8EUpzOGZpBxlDt2eoIefY1PDj
         1k3Piz522/8FA4Ys8L0UsU3zzw+vmG8nMkOK05jnuhe31yAAzQaP9ynlNwimA+WC/t
         CRnrv2eKPc9wEh3lNLz5BhVBoTbQjKZJNe0ipfwUwtM4w8qQxs+7dlGnL9ryjQj9N2
         piKpDJjX+YEriyN+wUa/m/RPXfj8GhFG/3J9hTUUnodmT3DNIetVulQW0SJ2nQ91C3
         6WXC6ADKj6jlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05780C4316B;
        Mon, 16 Oct 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as
 BROKEN_LE_CODED
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169747802401.23804.5795808252113645471.git-patchwork-notify@kernel.org>
Date:   Mon, 16 Oct 2023 17:40:24 +0000
References: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
In-Reply-To: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
To:     Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
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

On Mon, 16 Oct 2023 09:13:08 +0200 you wrote:
> From: Janne Grunau <j@jannau.net>
> 
> bcm4378 and bcm4387 claim to support LE Coded PHY but fail to pair
> (reliably) with BLE devices if it is enabled.
> On bcm4378 pairing usually succeeds after 2-3 tries. On bcm4387
> pairing appears to be completely broken.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED
    https://git.kernel.org/bluetooth/bluetooth-next/c/b00d44276894

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


