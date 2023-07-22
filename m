Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4975DDEF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGVRgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGVRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76AB211E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 10:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5592D609AD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 17:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7A09C433C8;
        Sat, 22 Jul 2023 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690047392;
        bh=JJ46K3XW4I0JpLQpuBXQf8Njr4YOEhYU8n3OoCk4mVo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jog2ffIQvaivXoTmVufyNIL5RLeWY+W5kLo/At63bMTGe9yqbgUMpiagtG5rh98jI
         8PDY9xZFB2e+9JYFiVI6s9HLJKE3HQyojEpO3E7Xqrb9iMN628BimCJdtGmomsTVol
         QMH24K0/1Q0UdST5ZpBGeuMH5aEjjIG4n8L/QtJtPon6qnjmwE9wa79X2GUpMhUg/p
         X28J3NERwR+eHj4d34jbfjRBIce4lslY//q/6BI9kv11tujYA58zI3Cr9DFu5HwcMP
         fjNcNCUUHDDZCcZpVOz9TGLVQEaDIErYc7VON+Vb0tQvNQ8YDC4EE+ST4bZbKOZW+O
         vjdYQcHz0VrCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D6E6C595C3;
        Sat, 22 Jul 2023 17:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230721193227.C8F05C433C9@smtp.kernel.org>
References: <20230721193227.C8F05C433C9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230721193227.C8F05C433C9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc2
X-PR-Tracked-Commit-Id: a9e26169cfda651802f88262a315146fbe4bc74c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39b1428639ed2224832234f48bfce991786aa4df
Message-Id: <169004739263.21373.14275905240849322964.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jul 2023 17:36:32 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 20:32:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39b1428639ed2224832234f48bfce991786aa4df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
