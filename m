Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A14799664
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbjIIFFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjIIFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:05:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4AE1BD3;
        Fri,  8 Sep 2023 22:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 989FEC433C7;
        Sat,  9 Sep 2023 05:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694235944;
        bh=GeCssub23t9bTXJ3thnoW4wDLpZD/1qQaVz4EHrdQhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TbwKIwYbQ/xteIOJ+frKomjMNKV/mzzE2ctvW9n/TbQsL0HPmCjoyq+CiKYKw1A2A
         yhrlvL2Xg1Pthlbec3P1jTmhFVoBCUcfNm18Vc5qwQMSbKwq8ltljhlFJsDWI5Xv7Q
         50nLjh5jBtzU4f45eK1yWbibeCzuUy/3TAoJqRGNn/EohHKREPnHkiN3BUlTIfOXlB
         oIDX0psrSQo1G+dt4fIvYAmFrwr/v5n31/zCJ69x35ZRSlhlR4pnslBtB6lRybKV+J
         vqNmSuveHcfJzAPoDIs6Qf9iPQQePtfm2bVSVRZouW9ebS75DSoFd63u0tJrPX2+1s
         ZPvKf/TDNaQ2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 861FFE22AFC;
        Sat,  9 Sep 2023 05:05:44 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt0Wuett3pQhGmynJxSTN2FriXxXT3zU-Qi5sk1uZ+SQg@mail.gmail.com>
References: <CAH2r5mt0Wuett3pQhGmynJxSTN2FriXxXT3zU-Qi5sk1uZ+SQg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt0Wuett3pQhGmynJxSTN2FriXxXT3zU-Qi5sk1uZ+SQg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.6-rc-ksmbd
X-PR-Tracked-Commit-Id: f5069159f32c8c943e047f22731317463c8e9b84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6099776f9f268e61fe5ecd721f994a8cfce5306f
Message-Id: <169423594454.31372.12322551557869380696.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 05:05:44 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 18:45:21 -0500:

> git://git.samba.org/ksmbd.git tags/6.6-rc-ksmbd

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6099776f9f268e61fe5ecd721f994a8cfce5306f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
