Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A902755A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGQD1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjGQD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:27:15 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51218B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:27:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R46vf6hGWzBHXlG
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:27:10 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689564430; x=1692156431; bh=Oyj+TYnFM2nBhAsEqO9sGZFdi1T
        41zSnIhBu9yxAGig=; b=ceI4ja6mW2skrEWD0o2pcg+KUCD/H0WA9GfGx+bcsEL
        uvNfgn10YaPtOjeWgzS0m9V4b/j6ZrZKaEZafMlOhmI8k1eCvUKDUNgLJMDeG/9U
        p/6uDHVH/qWT3l1DDYtCdEtpiWsIWzSqYPNMduQPMuiJgCwctTkqs9Omb54wYGeL
        44z5rBWCbFmZxGGhKOC1VlwnLQEe81kbCguVaXQWy1Y6ypNTDSbXvCBQri4iEK0f
        8IOwiV1G4cb0qKsdBxFxxVRSC3jEdsC7pHNGAt+NXLD/jGDvnFO73la4W/xtoPv3
        qYaBU2BCOCWn7PeLmK68HLaBiXQqxFHw97Uwca1cLPw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bqrS7_XrNMOW for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:27:10 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R46vf1jWLzBHXR9;
        Mon, 17 Jul 2023 11:27:10 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:27:10 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 3c59x: Add space around '='
In-Reply-To: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
References: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <304ca645a55aa0affe830bd36edaf24d@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

./drivers/net/ethernet/3com/3c59x.c:716: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)
./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
that '=' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/3com/3c59x.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c 
b/drivers/net/ethernet/3com/3c59x.c
index 082388b..9aa3244 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -713,8 +713,8 @@ static void window_set(struct vortex_private *vp, 
int window)
     Note that we deviate from the 3Com order by checking 10base2 before 
AUI.
   */
  enum xcvr_types {
-    XCVR_10baseT=0, XCVR_AUI, XCVR_10baseTOnly, XCVR_10base2, 
XCVR_100baseTx,
-    XCVR_100baseFx, XCVR_MII=6, XCVR_NWAY=8, XCVR_ExtMII=9, 
XCVR_Default=10,
+    XCVR_10baseT = 0, XCVR_AUI, XCVR_10baseTOnly, XCVR_10base2, 
XCVR_100baseTx,
+    XCVR_100baseFx, XCVR_MII = 6, XCVR_NWAY = 8, XCVR_ExtMII = 9, 
XCVR_Default = 10,
  };

  static const struct media_table {
