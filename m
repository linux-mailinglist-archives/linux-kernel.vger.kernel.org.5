Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6397C7D1ECB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjJUR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjJUR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04297D61;
        Sat, 21 Oct 2023 10:57:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A038BC433C9;
        Sat, 21 Oct 2023 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697911031;
        bh=LGQlCRTI+vRY2OarQLfo/9MacXicOfhnwyY3bQJOUqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JuEbzapjrLOe3k5Tz7BG1bxiO+rIU0EH3rTaaPCnKBguPH0cZlGgSALFYogbHr5dn
         ktaW4LSKeADhD4y4o3kTpIAYih/KduBSHiYz//lIWbm104hlHbKnwNLHD49lG9A+lE
         dkt4wBpWJ4FIrIW8BoJ5Ox3W+Z9vA8fJs51WCyDXizFaiJK9DoFhwsPj1Vn8ZjWQNy
         IjL3K49viTkT0bJiOBc8Wf48n8QEdKeqoy4+yRpuvv26vrgqNuCxn1EIO2JvEWocJz
         uRqWXvyw5OoRCQllaZkde5xBv1nP7oC12krZlgPA7J/DfTQghi5rKR4nQzS6gljQ+0
         YDOzYdGJmjIdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A4B9C04DD9;
        Sat, 21 Oct 2023 17:57:11 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.6-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bc630929-8352-5548-07ec-1de7ccc150e8@redhat.com>
References: <bc630929-8352-5548-07ec-1de7ccc150e8@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc630929-8352-5548-07ec-1de7ccc150e8@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-5
X-PR-Tracked-Commit-Id: 99c09c985e5973c8f0ad976ebae069548dd86f12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f51de61ce7cf27202fe1357b6c35a39a98ecd9cf
Message-Id: <169791103156.24251.2134261181125641463.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 17:57:11 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Armin Wolf <W_Armin@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 11:38:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f51de61ce7cf27202fe1357b6c35a39a98ecd9cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
