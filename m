Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F4770E63
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjHEHVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHEHVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:40 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377BC4EC9;
        Sat,  5 Aug 2023 00:21:38 -0700 (PDT)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qSBbS-0002p2-N6; Sat, 05 Aug 2023 09:21:34 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 1/5] docs: stable-kernel-rules: improve structure by changing headlines
Date:   Sat,  5 Aug 2023 09:21:29 +0200
Message-Id: <0737676f951050b2ec39e1662ffea37d77ef0bec.1691219455.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1691219455.git.linux@leemhuis.info>
References: <cover.1691219455.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1691220098;d8ef99a8;
X-HE-SMSGID: 1qSBbS-0002p2-N6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* replace a needless sub-heading with a short intro sentence
* make "Following the submission" a proper sub-section with a headline
  without changing the text of the section

CC: Greg KH <gregkh@linuxfoundation.org>
CC: Sasha Levin <sashal@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index d3f040c2738e..e68a76abe44b 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -39,8 +39,7 @@ Procedure for submitting patches to the -stable tree
    process but should follow the procedures in
    :ref:`Documentation/process/security-bugs.rst <securitybugs>`.
 
-For all other submissions, choose one of the following procedures
------------------------------------------------------------------
+There are three options to submit a change to -stable trees:
 
 .. _option_1:
 
@@ -153,13 +152,15 @@ problems:
 
      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for >= 6.3
 
-Following the submission:
+Following the submission
+------------------------
 
- - The sender will receive an ACK when the patch has been accepted into the
-   queue, or a NAK if the patch is rejected.  This response might take a few
-   days, according to the developer's schedules.
- - If accepted, the patch will be added to the -stable queue, for review by
-   other developers and by the relevant subsystem maintainer.
+The sender will receive an ACK when the patch has been accepted into the
+queue, or a NAK if the patch is rejected.  This response might take a few
+days, according to the developer's schedules.
+
+If accepted, the patch will be added to the -stable queue, for review by other
+developers and by the relevant subsystem maintainer.
 
 
 Review cycle
-- 
2.40.1

