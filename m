Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C97E49E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbjKGUeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjKGUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:34:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0489C10D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:34:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A124BC433C7;
        Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699389255;
        bh=mnsmi8fXcBcXYZnIcsE/D3fsbOE4Kfi0tznMTM2k0KI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o2vVLxAOZQaanDjDXT+1uwLNpME8nvdvp3QFu+w/mW6sYNAKvrGurkmx5QyxP4P6T
         RZvPOMVhx0/39cMbC5y/HxX0sI/saFMjpOUSswPW39gxPHbpw5TqrLgQtrybDjqMS1
         KZ+hXKAfBxKUS0LzYDRyAK4rvyFv1cgaIOfXPBZjPYgGOV/u4NDGdZ9THIAyjlK3G8
         mNKA6DXOFEYTGVXfJfalwYz/6A0Xq9fBV+Znx+jJXo1XWm4WiWfiYDgDZkGIQy5XGu
         jeQ/4yLXFPW6gFOPrngUuVq4YHxPaUh/tdhbUZUlwes37pVIdg1aAF/7zdQk8jN4ug
         1jKgRA5wUwgCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2C5E00083;
        Tue,  7 Nov 2023 20:34:15 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231107142154.613991-1-agruenba@redhat.com>
References: <20231107142154.613991-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107142154.613991-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc2-fixes
X-PR-Tracked-Commit-Id: 0cdc6f44e9fdc2d20d720145bf99a39f611f6d61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a0507d8780e2902c4c17c5a4c45d298bd7048af
Message-Id: <169938925558.27832.12377411515776609324.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Nov 2023 20:34:15 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Nov 2023 15:21:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.6-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a0507d8780e2902c4c17c5a4c45d298bd7048af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
