Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6076D940
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjHBVKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjHBVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FA30C3;
        Wed,  2 Aug 2023 14:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48B961B23;
        Wed,  2 Aug 2023 21:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 428B7C433C9;
        Wed,  2 Aug 2023 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691010623;
        bh=HKZo0dVHBh4Cp5PSXTEsqA47UzzSgcKTLbt7nmNF2Zg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RYCOpfpkILLMWlN96Tqg2OLxcjBZEc46bhIaiN8Pbe8hhtHX93X2RsPuXvPLCHasH
         3Gdpy29jVVxpv7FWibv7Fy/EHe6I0miEABqZ9M/3CflXNsEV0LmDB4V0gebU/wK+nL
         vO6GyC6BpkaEaOfSurXVrrWJgR8O6PDxxN8/mpKe1LAxUEnYs5x2ckZyph9d4ekxgQ
         g5QdjP5NZU2onRp4OR/2wtdOm+LYp8mJw+pMLlXhXjVeZwL1Yro1wI49Hr0XohxC4F
         +Hrq3NhYLbb1qGbGGaDTIHwL1QqLfm2molNRTUkv5k5bGGJX3S0Pwx2GVba97OJX4E
         i/0HKNqix9oPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B7C4C6445B;
        Wed,  2 Aug 2023 21:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 -next] Bluetooth: Remove unused declaration
 amp_read_loc_info()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169101062317.23031.2805028576245980577.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:10:23 +0000
References: <20230728033011.12096-1-yuehaibing@huawei.com>
In-Reply-To: <20230728033011.12096-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de
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

On Fri, 28 Jul 2023 11:30:11 +0800 you wrote:
> This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
> and never be implemented.
> 
> Fixes: 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v3: Add Fixes tag
> v2: fix SOB and update commit log
> 
> [...]

Here is the summary with links:
  - [v3,-next] Bluetooth: Remove unused declaration amp_read_loc_info()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c8573f208a12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


