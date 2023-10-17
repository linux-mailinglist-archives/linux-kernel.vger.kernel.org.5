Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1227CD0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjJQXab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjJQXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEDC103;
        Tue, 17 Oct 2023 16:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C90FEC433CB;
        Tue, 17 Oct 2023 23:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697585425;
        bh=ZAyjbke2TjqJcwoIhucIv9TG3uMrAnnnU9qwH6ECYQ0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t919TXtE9N1pfTLgLwbTwfhFjIJL6DO6rB1sdnr1hfyGYpL7YSLfddg7Ij7y1XDB7
         yIh71a5cCpBI3gyhC2gOGxXE5MgW1uK43r4zt2IwncbPk3lp4udziBXaHWtGImjj4+
         ovJRT2ujOyN+71CxXCefyqDdZLtL/TTfAPsaaaKOwEc5QVxUxfmDJJgIai2SLxKiSF
         IVpVa/R07xt7rTqWomy3Zr5WmLDiEuQ0hoAFy1sB2UKtUdzfIb4min8iPcDEQIJJCk
         pa39l0pEV79zJI4QS/nR+JK3nnXsKZlkvc2/8WEHT/fLkzbt2rg1KtVLMQaQUX1rg9
         lFcwHSlZyxAgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A942BC04E24;
        Tue, 17 Oct 2023 23:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169758542568.4587.5920833611147387224.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 23:30:25 +0000
References: <20231012112118.11431-1-guanwentao@uniontech.com>
In-Reply-To: <20231012112118.11431-1-guanwentao@uniontech.com>
To:     Guan Wentao <guanwentao@uniontech.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Thu, 12 Oct 2023 19:21:17 +0800 you wrote:
> Add PID/VID 0bda:b85b for Realtek RTL8852BE USB bluetooth part.
> The PID/VID was reported by the patch last year. [1]
> Some SBCs like rockpi 5B A8 module contains the device.
> And it`s founded in website. [2] [3]
> 
> Here is the device tables in /sys/kernel/debug/usb/devices .
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE
    https://git.kernel.org/bluetooth/bluetooth-next/c/9bb309db620f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


