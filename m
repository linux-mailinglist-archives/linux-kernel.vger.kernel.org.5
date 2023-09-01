Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A2790139
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjIARKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350515AbjIARK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9697E1711;
        Fri,  1 Sep 2023 10:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 429CFB825CD;
        Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07A2DC433C9;
        Fri,  1 Sep 2023 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693588219;
        bh=TGHz0mRYfsnlu58QNgvG8+a75gWBSIJymoDjZqF/64c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=shmyIaceA3lzgYMAS0hAdz+dNkT8v4pO32P9YE7Y/sA5odN3eX2ftLMeZ8ri1LOu3
         jd/GfVHsPggTJ1ngPXk9D1qnITvccPIdZ9bkpL4Asrn2BQtvC7UDm+rUfek06SCWX7
         UWG291CbfW2kh0m43+WbpMFfkfYykhM+gPMVBLdzb4qIQdmt1QRGLj9FAxo6VDNWJZ
         rGXqYXE8zF/o9RXoCB0Fs/u0DCQNGzJMDqKstc3U9sR+lOCNjidHXhFa8xwWqunqWo
         gVlTDVaAdQ52VowsI+HSnpHfcwDk/gHHQny+HOuvOAWJJx1j/M8UMfEYYxLOcXXiUe
         pbef3gkghNsjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6F49C595D2;
        Fri,  1 Sep 2023 17:10:18 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt / PHY driver updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPIA-hKjQRX1le-b@kroah.com>
References: <ZPIA-hKjQRX1le-b@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPIA-hKjQRX1le-b@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc1
X-PR-Tracked-Commit-Id: 895ed7eb263d7ce2d2592fdd3e211464a556084a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51e7accbe8ab51476fbe55fbb5616c12fb3a0beb
Message-Id: <169358821893.1073.11332990207567990714.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 17:10:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 17:19:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51e7accbe8ab51476fbe55fbb5616c12fb3a0beb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
