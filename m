Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E480B645
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjLIUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:34:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E863A13A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:34:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B040C433C9;
        Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702154057;
        bh=g4MWFVst4anvyJd7lfKmr0KWl7rxcGNlgzOvgLzAZcA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vGh5Ex3h6wLAjYXp7LFntwhwDTnmacg/u5ZV+4ycYd14YmBp58EzKjLEMyGSxGK4U
         VTyg0UG2yEMgYQH2zu5MOvyBVvKmDYrCcuAnYkB9oeMFrN5WcRIgUykC2AbtWyh+kL
         iMCvi8rJhSNNFBZB4tQF0awsTd1u0ZZtRB+c9Pe8MAne6kThyRWNU6sYgrvOIF9bVQ
         h0AmkXT5S7AxlM5ydaONgzVjlDV0j7G27FSn3BSfzyKRpwi2fqCiqlqbrHYyS0IWGv
         6YXEG2fP0gBhHGEUmuD+Z8u8sPB2j/8++Pm5VQ4dkQB9ZUaZm1Q5Csff2bfiBxe5Mb
         AUdr0Gi7WRndQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79A99C41677;
        Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtBLhwXUy3KtDxuqAnUJnxav=GFsR+V6ejp1XHpYaDmrQ@mail.gmail.com>
References: <CAH2r5mtBLhwXUy3KtDxuqAnUJnxav=GFsR+V6ejp1XHpYaDmrQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtBLhwXUy3KtDxuqAnUJnxav=GFsR+V6ejp1XHpYaDmrQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc4-smb3-client-fixes
X-PR-Tracked-Commit-Id: 04909192ada3285070f8ced0af7f07735478b364
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2099306c4e1d5d772b150aeac68fdd1d0331b09d
Message-Id: <170215405749.1707.13043642209572031850.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 20:34:17 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Dec 2023 16:26:48 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc4-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2099306c4e1d5d772b150aeac68fdd1d0331b09d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
