Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB9770E5B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjHEHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107C4EC4;
        Sat,  5 Aug 2023 00:21:35 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbS-0002p2-Cx; Sat, 05 Aug 2023 09:21:34 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] docs: stable-kernel-rules: improve structure and a few tweaks
Date:   Sat,  5 Aug 2023 09:21:28 +0200
Message-Id: <cover.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220096;232e9b6a;
X-HE-SMSGID: 1qSBbS-0002p2-Cx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding something to this document earlier I noticed that readers
need to perform some back and forth to fully understand things; I also
noticed a few other aspects that seemed somewhat odd for me with my
background on writing and editing texts.

Find attached a few patches to improve things. The first three are
mainly moving text around to a structure which is somewhat clearer. They
leave quite a few rough edges behind that are fixed in in the last patch
of the series, which changes a few other changes as well; thx to the
prep patches the diff should be relative straight-forward to understand.

These patches are on-top of the following series that currently is in the 
driver-core-testing branch:
https://lore.kernel.org/all/cover.1689056247.git.linux@leemhuis.info/

Ciao, Thorsten

v1:
* new patch-set based on patch 3/3 and other feedback to the following
  patchset[1], but slit off into a seperate set with four distinct
  patches to make it easier to see what is actually changed
  https://lore.kernel.org/linux-doc/d30686781c47c83927e0a41f6a1167a679fa822c.1689008220.git.linux@leemhuis.info/
* append one more patch for something that came up

Thorsten Leemhuis (5):
  docs: stable-kernel-rules: improve structure by changing headlines
  docs: stable-kernel-rules: move text around to improve flow
  docs: stable-kernel-rules: make the examples for option 1 a proper
    list
  docs: stable-kernel-rules: fine-tune various details
  docs: stable-kernel-rules: mention that regressions must be prevented

 Documentation/process/stable-kernel-rules.rst | 165 ++++++++++--------
 1 file changed, 91 insertions(+), 74 deletions(-)


base-commit: 016571b6d52deb473676fb4d24baf8ed3667ae21
prerequisite-patch-id: b00970f680f3032fe8a7d0e3843b76d60c2f0458
prerequisite-patch-id: 9926a13726e99d51800f52cb84e26ae971757467
-- 
2.40.1

