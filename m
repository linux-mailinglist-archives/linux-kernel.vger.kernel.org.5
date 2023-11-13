Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13F7E959E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKMDml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMDmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:42:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C8DD1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:42:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1057BC433CA;
        Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699846957;
        bh=kGJyOvpDxTZaVrZCrdCVgS8x/lCtZImGpHerwOJCbsg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AEgMwVkoFkZMLSPaKUM53En46MNelSD0xuZxg30ul+OkWrtnasxYtPrQw/PtkxLz8
         zmt7jfC6XP4O38VOyP25f4a7EPvQinITwb2hfQObeZsQUkmqn78WuqiCypP23F3LJF
         /I4aMPloLM17BaaYFftcfmkaPRcN3Nf0q7wN0eXiPPAmGdgDO3wwYHOkbxd4i6lG2z
         tkWHK6nM2F1efK/5hS2E24Heo3YG6E28tgVU7KsEWFKK8OjGSOcnWzyl+eFlD/ZJrn
         AnDmvSiSj/6rMQ+wox5GPllN6BmxNFQpsk40yAhxQxMZdWrqcOkAtzyLtCKrgZRwK2
         /0fcNnPCutyjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAAECC4166E;
        Mon, 13 Nov 2023 03:42:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/5] Displayport Alternate Mode 2.1 Support
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984695695.27851.10747902999739625295.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:42:36 +0000
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
In-Reply-To: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
To:     Patel@ci.codeaurora.org, Utkarsh H <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 19 Sep 2023 19:32:38 -0700 you wrote:
> This series enabels cable identification flow required for Displayport
> Alternate Mode 2.1 support.
> 
> Please add this series to usb-next.
> 
> Changes in v4:
> - Added [PATCH 3/5] back in this series with Reviewed-by tag from Heikki.
> 
> [...]

Here is the summary with links:
  - [v4,1/5] usb: typec: Add Displayport Alternate Mode 2.1 Support
    https://git.kernel.org/chrome-platform/c/a17fae8fc38e
  - [v4,2/5] usb: typec: Add Active or Passive cable defination to cable discover mode VDO
    https://git.kernel.org/chrome-platform/c/c365b1e1f404
  - [v4,3/5] usb: pd: Add helper macro to get Type C cable speed
    https://git.kernel.org/chrome-platform/c/f9ee6043283a
  - [v4,4/5] platform/chrome: cros_ec_typec: Add Displayport Alternatemode 2.1 Support
    https://git.kernel.org/chrome-platform/c/70ca6c7312c5
  - [v4,5/5] usb: typec: intel_pmc_mux: Configure Displayport Alternate mode 2.1
    https://git.kernel.org/chrome-platform/c/6c29de68fb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


