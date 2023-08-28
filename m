Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AF678BB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjH1XKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjH1XKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFD185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E8D64814
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0403C433C7;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693264233;
        bh=E23kXWJx2A4D5plz4UDc/9GndFzK21Sp9eeFWw3u+98=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UFAaandCqpMYkGKp+b1addqFHbrlQei1sJLW1sY2/0Ak8hokOEXEeijlAwIQj937a
         e2NJCX7HDz0jKmRylnZz29bZ9abuDHHBF5fzq+MFdGGbKxv7vvcghBbsfftgaHah3s
         i/Yd1HsRpNnXwgI9xZds0Kc7P15nM8mkQYr1BUUVrr984WlZfitIk85EX+/gjUQdIw
         230xSYA1tQmhx4LKAn/kt+lut/DJJUdfLgdfEbxU2IOzOy1aYot2ZijEjBZ4UBkohi
         XRzsImiFUUZyxeqXYM4AJ+klWDP7pRmJtML7wH/0wIMz8sOs61jZXggWk7Lo5/tZCx
         znu1GWQzewfiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CAB3C3274C;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828120847.GAZOyOT4IQn1XImJz4@fat_crate.local>
References: <20230828120847.GAZOyOT4IQn1XImJz4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828120847.GAZOyOT4IQn1XImJz4@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.6_rc1
X-PR-Tracked-Commit-Id: ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f31f663fa943c88683777bb8481d2d5d74e426d0
Message-Id: <169326423357.4748.3193840201275074771.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 23:10:33 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:08:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.6_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f31f663fa943c88683777bb8481d2d5d74e426d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
