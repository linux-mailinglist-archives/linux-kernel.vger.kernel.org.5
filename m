Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF97F80F1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbjKXSyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbjKXSyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:54:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D62705
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:54:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BC9BC433C8;
        Fri, 24 Nov 2023 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700852053;
        bh=664Y8MA/0B47W1i3on5LKRuCh4LThPWg5J+MHY1/lOs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ieaLaiFuuzuZQlgVuhEwYB2Xqlwd7Lw5YxWMC/ZXzBul4rPGR1AhOcO0D6EyQeB6a
         JHjxKkI7Gqei6izM7IfNQchrfpiFus/zJNuM1ZeD9pPhcHU9u/rQsEnLxyXHJxHxlG
         A1G5/B9Qr5PfHk6keJy8yxTJshulcVb/yoAmZfKXOo20+ak+zkcauwBIZiqQtq9SRo
         usoNWBqxj0AtSBpsK7eJ1umQsQNfBsKaA9UGs7tlGx1cOo9q3UexKVFrvaKq4xeQuc
         58wjlwVc5/JAhKB0pfgf8P+mxfkKREF5+pvnfZNvk4Kg29iRn3pNlKJxl0fJAcsAH2
         KbAIa0QTc+nZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47619EAA95E;
        Fri, 24 Nov 2023 18:54:13 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1205248.1700841140@warthog.procyon.org.uk>
References: <1205248.1700841140@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1205248.1700841140@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231124
X-PR-Tracked-Commit-Id: 68516f60c1d8b0a71e516d630f66b99cb50e0150
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7ad877e4d81f8904ce83982b1ba5c6e83deccb
Message-Id: <170085205328.28485.6142612157773740209.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 18:54:13 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Nov 2023 15:52:20 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20231124

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7ad877e4d81f8904ce83982b1ba5c6e83deccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
