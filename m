Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF27E10AE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjKDTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjKDTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:01:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72963184
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17D0DC433C7;
        Sat,  4 Nov 2023 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699124497;
        bh=pPXv+Dhg8MJVPKpR3UEPO6pjR26WZm1ueLYPx/d7Lm4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UVzNgw190o2bSKKch6Gor/iIXKDenZuWvmWIVRIAbV9ZO3Wg1rTzh7iJJjn7mwWSN
         Ow0ZpXg+NOXiwRRyltwzqX8gqarfkVQ4/UoLxmClIGEHKuxkHKJPasuA/RdlRGuKvL
         vXV1xwCQPgpdu84X94zh/4SpShHJA2WkvI4Ul7Eh9x7k7q7B/B7zYwuVE2HN0STadp
         KOGzN8XW/xMgwjOjb2RESTe6subY6ZmyVNZmbZNGW3ei2aTZ9XMwAqQDWuOImD40E6
         bLUR+jIRI26htM/oo45S66B6IXat2mwag9caP9cicdlDu7EXTwyj/JGc+RaEBW286k
         R+StFrFOzon0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04C40C4316B;
        Sat,  4 Nov 2023 19:01:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_microcode_for_v6.7_rc1
X-PR-Tracked-Commit-Id: cf5ab01c87030a085e211a0a327535932ec6f719
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a23fb262d17f587c9bb1e6cc83ad4158b21f16e
Message-Id: <169912449700.2096.3226842438827049234.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:01:37 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 12:06:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_microcode_for_v6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a23fb262d17f587c9bb1e6cc83ad4158b21f16e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
