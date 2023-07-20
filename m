Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEF75BB53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGTXuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTXuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2E2737;
        Thu, 20 Jul 2023 16:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0973261CCB;
        Thu, 20 Jul 2023 23:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65762C433C9;
        Thu, 20 Jul 2023 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689897021;
        bh=09vCGBt4albRAEEXLRSkOtlpb9RvRo/i9QsRDRcbhbI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JEYUAI39Y1KlbZ7XtNL7H+F12w2SAWKG8LmItZZdg+CduhUQAWCwji5t0RsavX7M6
         xqPT6UGP3wlWT1nIbVhaZKiFS5zEzXk8J5l4/id2C+/UWPbM5NHSm2scx4zIw71fiI
         ayfCe34Y66f07GRoML16z4l9pvG20XUbrZ8gJqlrkiFPgPZrvHN+h4WhnSzLQEpWOI
         9WWaTPvmEo6BjQ9olFn4B1WOCf50+bPi1ppbuWF+DayMzKY3k4bN7jslepqaWw5di2
         ooBcLQVixZRjjDbBK+Cm3AryQFCkf1Scsz502wBwQ1OI3ZSYYzev8jygmosjc28+4T
         qiSTfmKw063WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B245E21EF6;
        Thu, 20 Jul 2023 23:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btbcm: add default address for BCM43430A1
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168989702130.8881.11036571095108497021.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 23:50:21 +0000
References: <20230715164159.16368-1-mans@mansr.com>
In-Reply-To: <20230715164159.16368-1-mans@mansr.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Jul 2023 17:41:59 +0100 you wrote:
> The BCM43430A1 has a default MAC address of AA:AA:AA:AA:AA:AA.
> Although, unlike some other entries, this does not include the
> chip name, it is clearly not a real address. This was found in
> AzureWave AW-NB197SM and AW-NM372SM modules.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btbcm: add default address for BCM43430A1
    https://git.kernel.org/bluetooth/bluetooth-next/c/2d54008f4b68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


