Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0178790A35
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjIBWzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjIBWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 18:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB224E5F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 15:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5770D60DF9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 22:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA3AEC433C7;
        Sat,  2 Sep 2023 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693695346;
        bh=w4RQ86thUvRYT0+27KBQvBs+IXLSffwIqALcZMH+WPg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sERHQE9fwTHtoXmL4KCRkVzXtKRsgYCE2UQwHCuaACgN4HcpImE5Xi+znKmeViY9x
         gl8MnQ+8kjHnpdxLYZeyCxTbFOwWZ1QupfBFfwyvJHE72CAdL5N2VgR18aqH1SQEmi
         uZg2m4c+cNCDIAarpwQPuzFC9vYiqC05RpcPFJcJqGyst4z+XKkn5qRbsUh/PZ5d7L
         IE9ZNr778cmrHPbB0OGHul3Dn+JFTOKPTm37fbmNjpkMqA19n844mcv56nP2SsO9N5
         8g91sKBrnPpZpOBK037Mv41kB5fs7+KRWkKAd65AyViwCot0+9+7U93UjacO9BaL5Q
         INUIXQedFClAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D982E26D49;
        Sat,  2 Sep 2023 22:55:46 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPJ7P1J+jbyL6Mve@google.com>
References: <ZPJ7P1J+jbyL6Mve@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPJ7P1J+jbyL6Mve@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6-6-rc1
X-PR-Tracked-Commit-Id: 3b7166121402a5062d18dcf4e3bce083fb9e4201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92901222f83d988617aee37680cb29e1a743b5e4
Message-Id: <169369534657.28928.8759587724835660824.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 22:55:46 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
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

The pull request you sent on Fri, 1 Sep 2023 17:01:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6-6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92901222f83d988617aee37680cb29e1a743b5e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
