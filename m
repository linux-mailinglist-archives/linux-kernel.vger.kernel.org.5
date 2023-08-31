Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62678E50D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbjHaDUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbjHaDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:20:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004ECF1;
        Wed, 30 Aug 2023 20:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF32B82172;
        Thu, 31 Aug 2023 03:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13FF5C433C7;
        Thu, 31 Aug 2023 03:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693452035;
        bh=yOuGmPkxw1I3boCORhF94UtvrRj1Uf3GXVOILfcBtHA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EkVjsmDWIY/ptEzc4I8dm7Ra64s/FERfpC02wnHWCMFcQS7XXsqcxAv/C5FEw7kJA
         VjWl62LwU7cC7cooQ/DaX+nRGY6peXeWYuXg1DvyNk3PMpWasRtMIYmTJYVMlZGYa+
         Hv+kXCShXcPxI5Qj/vuCYJPJwiASP6kmOh+LtVzBXXTfxdjxRr471xN7yEkQfSoaoz
         KzCQ1vMGkTaPgQWmvGFBAMAHWzUNBKG8wi7cdQfyDTZyuXWT1+HJOJyjvgNrwBdib8
         Sl1CHKvf9D7sB/pfHdF+KLWa57Opxnu3JcA+IUrleynBOwIGwgucTAUme8GRIrMhzC
         kwFgsyyVg8ykw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00E5FC595D2;
        Thu, 31 Aug 2023 03:20:35 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC drivers
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO55fLRfOawcoxQt@agluck-desk3>
References: <ZO55fLRfOawcoxQt@agluck-desk3>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO55fLRfOawcoxQt@agluck-desk3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.6
X-PR-Tracked-Commit-Id: ce53ad81ed36c24aff075f94474adecfabfcf239
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb511d4b25a75bd67c4db4dcb570b2ca3b42c926
Message-Id: <169345203499.31998.16048958411977496589.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 03:20:34 +0000
To:     Tony Luck <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
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

The pull request you sent on Tue, 29 Aug 2023 16:04:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb511d4b25a75bd67c4db4dcb570b2ca3b42c926

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
