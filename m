Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC47E49E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbjKGUeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343784AbjKGUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:34:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200BA2;
        Tue,  7 Nov 2023 12:34:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F11DDC433C8;
        Tue,  7 Nov 2023 20:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699389255;
        bh=xCg+lsATlOW8hA5YHl6Nt6b45lfS+nysNUt/mT8E2rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k4CljGe5SYDx44ZHW/ynMflwbEN9pv9x5fkr/jj+y7lxP/yoHPZVMThh7sifnqVvx
         SGeea7uhtYhGTU+pThKN+3FBzCDfbmhEq5B+Pa9jVebZJqqZTVDRgdV+ybsWzFyDnc
         buS9MUND2xjUowvdFO3QjLViVnkvFONn8stSoWbIjxYF6mifShqWxfSiukQHuY6sVg
         nfmLrwELC0HUG22IO5PbtGzkM1+YU2vpxxzOr5OgwtL4jJBH5OEV4p5mhyGDCe9q4o
         7ZmyA6Xn/dCa6luakukiCMQDHjDC17OV4ufuIkLoOIstGjdE+jXnaXqVaOjj7L/ngP
         64KtNhlVY4avA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DED65E00083;
        Tue,  7 Nov 2023 20:34:14 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231106065045.895874-1-amir73il@gmail.com>
References: <20231106065045.895874-1-amir73il@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231106065045.895874-1-amir73il@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.7
X-PR-Tracked-Commit-Id: 24e16e385f2272b1a9df51337a5c32d28a29c7ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f851936a0ca4b231224ee296cba28f9b1bc555e
Message-Id: <169938925490.27832.6319931975488901259.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Nov 2023 20:34:14 +0000
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Nov 2023 08:50:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f851936a0ca4b231224ee296cba28f9b1bc555e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
