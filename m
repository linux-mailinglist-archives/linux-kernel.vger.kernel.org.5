Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DD76D71D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjHBSsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHBSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BF12C;
        Wed,  2 Aug 2023 11:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF5061377;
        Wed,  2 Aug 2023 18:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0765C433C8;
        Wed,  2 Aug 2023 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691002107;
        bh=B9BW05KN3RWMKVsfci7psfVLAqLrOIip0aj75rwOQhg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=inLH42yzBmqZcQKnCuBmHqhqC2zZM/1RpWIe6U4uij34IN7ax2m/amqa4v+g0Dmv+
         ZuJAPyyoKmavvsKTjXLdJd/m492Uil/LW4Hey66/L1/Tc6snLgZ9Rss8THSb3b34jt
         56xV2oTo37TC9b9+MwbmCNqazK+AWztHTi3Lm3qI/F2KE6z1ucWCAgzRceiHGVRJHu
         d93dJr/29lCdSNfrfyfZE6QFdjh18TGtbVpc0t04Gn0U2ukWBI5zquveWsl3QSpwfq
         M4xqv1/iMCp7uSJZMItJzMcliI+BO02G9bY8S4N185osIqzRbAYoThynFAgFCqUDp+
         0iTUMnEeG6Sug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A7ADE96ABD;
        Wed,  2 Aug 2023 18:48:27 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1c724252a3ed052637853107dbe13b898f237c3f.camel@HansenPartnership.com>
References: <1c724252a3ed052637853107dbe13b898f237c3f.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1c724252a3ed052637853107dbe13b898f237c3f.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d4e0265345778c623d1fe619075b677731847c34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79d65ee53b968c006ad382a4d4c2dccd898706f9
Message-Id: <169100210762.11440.17608765517782979675.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Aug 2023 18:48:27 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Jul 2023 13:55:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79d65ee53b968c006ad382a4d4c2dccd898706f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
