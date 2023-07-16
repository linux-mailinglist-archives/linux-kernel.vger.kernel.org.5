Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206E754D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGPEx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 00:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGPEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 00:53:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4841729
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 21:53:55 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R3Xt75DVgzBHXgq
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:53:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689483231; x=1692075232; bh=gS2d9ombR8HAaNSLxJlzXEer9Xo
        +jbEvrJ0SW3gBj2s=; b=y9/JfScVJ/D5Cpp9k4D2mvUxKZJ+lAAha06XxZwBjsj
        qboodizJgFIxwupW4MshAGdvNI+aRlKq9mUdouX3E8Cf60i1kDKsN+aIxDOcLj7w
        6nBZ0+xYebEoTm67OzJ7At/h5KNbQrS0bOEErdbG0NwMwgRLkMdsgjqYQgatHM57
        b4u+uHhaAMZ2ds8yU9mRJIAYcjRnKCr0hQntXC9pHj+vBFQgUG1hbXTazqoXH5HI
        K4cP3ScmM6xKFbisyTy6G77LHywgq/kUINGoWD9NpYLAS78b52sNf6ruPt8hCAQO
        LycWhs5iCLTZTwJ1m5dxjFyfida1c6gHJswdc62cecA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w89UBzFDSCrk for <linux-kernel@vger.kernel.org>;
        Sun, 16 Jul 2023 12:53:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R3Xt73RpXzBHXgf;
        Sun, 16 Jul 2023 12:53:51 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 16 Jul 2023 12:53:51 +0800
From:   wuyonggang001@208suo.com
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ssb: Modify Format
In-Reply-To: <20230716045151.26193-1-zhanglibing@cdjrlc.com>
References: <20230716045151.26193-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <09e3401881baccc7c535fb9f92b4cca8@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error(s):

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/ssb/driver_chipcommon_pmu.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/driver_chipcommon_pmu.c 
b/drivers/ssb/driver_chipcommon_pmu.c
index 888069e10659..058d70ac6ec8 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -72,7 +72,7 @@ static const struct pmu0_plltab_entry pmu0_plltab[] = 
{
  };
  #define SSB_PMU0_DEFAULT_XTALFREQ    20000

-static const struct pmu0_plltab_entry * pmu0_plltab_find_entry(u32 
crystalfreq)
+static const struct pmu0_plltab_entry *pmu0_plltab_find_entry(u32 
crystalfreq)
  {
      const struct pmu0_plltab_entry *e;
      unsigned int i;
@@ -203,7 +203,7 @@ static const struct pmu1_plltab_entry pmu1_plltab[] 
= {

  #define SSB_PMU1_DEFAULT_XTALFREQ    15360

-static const struct pmu1_plltab_entry * pmu1_plltab_find_entry(u32 
crystalfreq)
+static const struct pmu1_plltab_entry *pmu1_plltab_find_entry(u32 
crystalfreq)
  {
      const struct pmu1_plltab_entry *e;
      unsigned int i;
