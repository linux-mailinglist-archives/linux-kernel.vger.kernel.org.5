Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED377D36E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjHOTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjHOTiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2910EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A9F60F6E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83CA6C433C8;
        Tue, 15 Aug 2023 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692128279;
        bh=XuHoVM39r/HzcX2yNhT/E8YXo97sADH+xaXhqDaOWno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VgOChbslpbxVcC6zjO4a3e5EVFJ/5UgbUIZfTBQfAImMr+ECvrDEz2xt5LkTPJbYk
         egABNvnBrG0nvecLF9+p0CEpXqS2wPUYyr5NznZ/FBUaxVmhnJP6WMfLOf//rCNtIO
         SL2b+qFxaEFQ56YA4oJSMG8RqJ/qod4P+SwSutV/XAo7C7gMUdSPpcPUiy8J7otLm8
         WAg6wq3d6vui2/XtQXf4raxbgNe9rhM83MRz0GZIny+R6R9mnTbes+3WAYJxU2j+HC
         IizSDtStmaJTLCmUnBRBguJpXQo7zqkyQ898T2+OFhKjf2njU1QIS9tTU0MAo1kOun
         SV392IiC34ing==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 713CAC395C5;
        Tue, 15 Aug 2023 19:37:59 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230815164701.4451BC433C7@smtp.kernel.org>
References: <20230815164701.4451BC433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230815164701.4451BC433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc6
X-PR-Tracked-Commit-Id: 7cdf55462c5533a1c78ae13ab8563558e30e4130
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f8e13b0614dc237deefb4e270d6d0f060bed70
Message-Id: <169212827945.11096.6664506427049212003.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Aug 2023 19:37:59 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Aug 2023 17:46:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f8e13b0614dc237deefb4e270d6d0f060bed70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
