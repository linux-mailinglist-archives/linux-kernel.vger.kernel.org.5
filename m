Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E37BF955
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJJLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjJJLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:11:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678FB4;
        Tue, 10 Oct 2023 04:11:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E94C433C9;
        Tue, 10 Oct 2023 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936263;
        bh=zrccQti7irl5eqt+h02FBL2SB1o+0Gba/2/xG95iqzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+DGTwDAq8CP86nlASZMFwkTPJx+pjfwriVkWbUEiy/3bioZwoYVKbCT5DEKrRLXg
         W3oqKdznwjr8+tT95wN1+W3iL7x+lfnrKKQCF3fc4w6aRe6rYpiJLAbj5lf3vZNlgi
         B6x4zWQ9Y6WBOdaxkNSE0jQSPhIdN9lD56xrTX7qEJqy/A+8x8U03Wqog/fQwGSre6
         74Ff8tfr99w+xdXzXh8xw7wKR8pm5m0i/0zoOMiaNw05BG09qnMdGng2nLm0gwFm10
         X/rKoawXd6zUWR6ePrSZtiv7WftQV4H81X+IMH6+hNFOvUpKPkCgSGvnhk8G/nKJFy
         Gpm6v61PcHXtQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Wei Zhang <zhangweilst@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] Documentation: RCU: Fix section numbers after adding Section 7 in whatisRCU.rst
Date:   Tue, 10 Oct 2023 13:10:51 +0200
Message-Id: <20231010111053.986507-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010111053.986507-1-frederic@kernel.org>
References: <20231010111053.986507-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Zhang <zhangweilst@gmail.com>

Signed-off-by: Wei Zhang <zhangweilst@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index e488c8e557a9..60ce02475142 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -59,8 +59,8 @@ experiment with should focus on Section 2.  People who prefer to start
 with example uses should focus on Sections 3 and 4.  People who need to
 understand the RCU implementation should focus on Section 5, then dive
 into the kernel source code.  People who reason best by analogy should
-focus on Section 6.  Section 7 serves as an index to the docbook API
-documentation, and Section 8 is the traditional answer key.
+focus on Section 6 and 7.  Section 8 serves as an index to the docbook
+API documentation, and Section 9 is the traditional answer key.
 
 So, start with the section that makes the most sense to you and your
 preferred method of learning.  If you need to know everything about
-- 
2.34.1

