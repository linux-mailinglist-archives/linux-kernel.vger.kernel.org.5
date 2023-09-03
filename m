Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CF790B75
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjICKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:25:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B801F110
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 03:25:11 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 383AP7EM066111;
        Sun, 3 Sep 2023 19:25:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 03 Sep 2023 19:25:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 383AP7NO066107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Sep 2023 19:25:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c4ed154e-ac0e-b002-4de3-c09f113a79fb@I-love.SAKURA.ne.jp>
Date:   Sun, 3 Sep 2023 19:25:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [GIT PULL] tomoyo update for v6.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 254a8ed6aab39c869d99da97f25035ed15756337:

  tomoyo: remove unused function declaration (2023-08-13 22:07:15 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230903

for you to fetch changes up to 254a8ed6aab39c869d99da97f25035ed15756337:

  tomoyo: remove unused function declaration (2023-08-13 22:07:15 +0900)

My gpg key's expiration date was extended by 10 years.
Please fetch from https://I-love.SAKURA.ne.jp/kumaneko-key as needed.
----------------------------------------------------------------
Three cleanup patches, no behavior changes.

tomoyo: remove unused function declaration
tomoyo: refactor deprecated strncpy
tomoyo: add format attributes to functions

 security/tomoyo/common.c |    1 +
 security/tomoyo/common.h |    6 ++----
 security/tomoyo/domain.c |    5 ++---
 3 files changed, 5 insertions(+), 7 deletions(-)

----------------------------------------------------------------
