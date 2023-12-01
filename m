Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7F800303
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377434AbjLAF2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377413AbjLAF2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:28:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDA1703
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:28:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E0E9C433C8;
        Fri,  1 Dec 2023 05:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701408520;
        bh=tSQelM7eBAmNf1cdkv0I8c8mRQqetzgavX9qKOzEMFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OHiXQBRBv6lHvnq2JtMwITPLxoJ1EJB/GSpx0Tt6j0fTTCPu9LjBJ9/mjSW1Sa1qQ
         MkZpb/4JpzZ18c5rbZnuv1Nj8Db+KLOtBkv3Q6R7RQz5S2plijFOWCzFBYJ1HKHbdo
         +1kpsmfRk2TnIdXQ0vY7q0XNx5yUZuucr9jfDFW7iVQ9Yenu/bZ7Q2sNI+DuIOrAfa
         LALEUmY+o7awtCMFBrVH8x+ftKT9ZeEWb6eT1HwSQAZlg+L18pudLL032osMJdCkiC
         0dCLFeWIkWAkYqXmgh+/+i8OPuF7KumdF5R3qzMy50IZg9lpueGUWCCJDq+zUJe7BB
         vnzNxWNbaGF0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B273C4166E;
        Fri,  1 Dec 2023 05:28:40 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202311301337.4070D0BEA3@keescook>
References: <202311301337.4070D0BEA3@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202311301337.4070D0BEA3@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc4
X-PR-Tracked-Commit-Id: d71f22365a9caca82d424f3a33445de46567e198
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 994d5c58e50e91bb02c7be4a91d5186292a895c8
Message-Id: <170140852030.12146.4538343310054301269.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Dec 2023 05:28:40 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Nov 2023 13:38:04 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/994d5c58e50e91bb02c7be4a91d5186292a895c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
