Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2067787E07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjHYCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242577AbjHYCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF5211D;
        Thu, 24 Aug 2023 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F5064542;
        Fri, 25 Aug 2023 02:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D1FEC433C8;
        Fri, 25 Aug 2023 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692931872;
        bh=4wthcCGK7UTEQggqK3+XS02OsVrGnYqqLtMdj3/SRxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z6SBrzS6PFZy8neDiEhxfmJqZR5HDhHhkWxumjDXHD2HLLzommJz6j+XVLbFqOv60
         UIx8jz3LeWLqFfwBYMhQwivxqKMK+LG5K0JupCpTrEJ7mxRoaokVcfW/Y86D5qDd58
         PEA0XGbh2LI5+EocK/WkMJ5lazEPFKeoNYHIrrOMJQmSUuCMK+2XjsDSCTCUWgYsir
         QZdKgr9F5XQDVt7SbeFYH0GAjKuIlSj/O+AW4aC9EEEd6oL7tm4ZJig5lt1fWjwAdR
         CNONwM/SyWnFM2/BgP9lu5Sz4rI7BXnsjX826mQkVkT8qdWu7SqWoqQ/AwqJFvZaRF
         7nqHDjmfXMXlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51680E21EDF;
        Fri, 25 Aug 2023 02:51:12 +0000 (UTC)
Subject: Re: [GIT PULL for v6.5] media fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230825015419.0848a4bc@coco.lan>
References: <20230825015419.0848a4bc@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230825015419.0848a4bc@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-4
X-PR-Tracked-Commit-Id: e7f2e65699e2290fd547ec12a17008764e5d9620
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14ddccc8a647f0e6b268858c4fe2804ae42aabb0
Message-Id: <169293187232.29499.8466139975370857444.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 02:51:12 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Aug 2023 01:54:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14ddccc8a647f0e6b268858c4fe2804ae42aabb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
