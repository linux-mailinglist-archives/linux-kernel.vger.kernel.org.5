Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EF7AC4A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjIWTI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjIWTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA11AD;
        Sat, 23 Sep 2023 12:08:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48030C433C8;
        Sat, 23 Sep 2023 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695496097;
        bh=rhcbZbTXffdOE5XTPb3/cZX3yFFem7hHu8Y8eSsU8wI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dy00ofeNdrqIRIwaF/x/u5edUoEv3CtNWbeUpxnWKyFAefm+4Y8q2IFbcFlyw54jX
         cHQRylaza9J3GRjjI43dMjDOImGXIC7+4xbgn79zG98ntpcFbGUbV3eN2/iqA45GbE
         U1YOxRe8QySunXFh2yJqUroP/hBhl4TQ7w0t/iYidAAVJ09ppWX+/UEft07zdEJ+K4
         0Qi8KUu8w3zZ0XwU0yYFZZ5RrHnpjQApsPCbBTYKsVHzpsFCYIRG0Vq823OWQtUiIp
         yIB4VnW203oVmUa1wbg/2sV/+pcGUDi9GVNGQIAyqQrLLj5BbvIVzcMRXtxD5XYduO
         igpZR7ZnKp7Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3567FC561EE;
        Sat, 23 Sep 2023 19:08:17 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muY+WP7WKfzpPxaGM53fdEEwCQnRgkwOFWFuh2y3Odb9A@mail.gmail.com>
References: <CAH2r5muY+WP7WKfzpPxaGM53fdEEwCQnRgkwOFWFuh2y3Odb9A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muY+WP7WKfzpPxaGM53fdEEwCQnRgkwOFWFuh2y3Odb9A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc2-smb3-client-fixes
X-PR-Tracked-Commit-Id: c8ebf077fbebda3a24335660ded7cff4b90331b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8565bdf8cd30cf5bf98efeb9fb53c39bf387e30c
Message-Id: <169549609721.2215.15100202092440608114.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Sep 2023 19:08:17 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Sep 2023 12:28:05 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8565bdf8cd30cf5bf98efeb9fb53c39bf387e30c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
