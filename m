Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1075EA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGXDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGXDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:40:38 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69776191
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:40:36 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Qst0dqKzBRDrF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:40:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690170033; x=1692762034; bh=KABsKwhWlx/kqYu0QsaS+UFrAdw
        /erZjiOwJTTEi4ag=; b=agiJFlnJzEzP5+bDy/xKfQ+BLhY/qznmGP9OfLxQtta
        NKQlHXWLH/m2gguSEt2Yl34VJ+EwNVXU6lGuXGqKzP8oUDP4M/5dfHucxEepxwMx
        ElEYElXlzVYduJOdr00UQU/jO/PXYEqd5kvHxrQDIbz5KPD3FQbRZEum/bH/uZET
        oU5IkzZeUHCq+L511Q6HwuM0z0nd6XDkIyvlkC49e8qwzn1CutJS5Q+cEowpVa+P
        bd4DkYnBxULPt/n2kqeEwl7BBajpdjZPdThcBKZcpdU6B4BxPhtyhnLkGze6sJLg
        vwUj2tUFVmXPa5esIEF5phCg0UgPbgx39lIBzZH2Jpg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c2vFPq4zL02M for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 11:40:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Qss5zx9zBJTF7;
        Mon, 24 Jul 2023 11:40:33 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 11:40:33 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: that open brace { should be on the previous line
In-Reply-To: <20230724033939.8147-1-xujianghui@cdjrlc.com>
References: <20230724033939.8147-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f558b5bf6037d0e0eadcaee9448ad4c6@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/radeon/rv770_smc.c | 36 ++++++++++--------------------
  1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rv770_smc.c 
b/drivers/gpu/drm/radeon/rv770_smc.c
index 45575c0d0a1d..09fa7f5e7c41 100644
--- a/drivers/gpu/drm/radeon/rv770_smc.c
+++ b/drivers/gpu/drm/radeon/rv770_smc.c
@@ -34,8 +34,7 @@
  #define FIRST_SMC_INT_VECT_REG 0xFFD8
  #define FIRST_INT_VECT_S19     0xFFC0

-static const u8 rv770_smc_int_vectors[] =
-{
+static const u8 rv770_smc_int_vectors[] = {
  	0x08, 0x10, 0x08, 0x10,
  	0x08, 0x10, 0x08, 0x10,
  	0x08, 0x10, 0x08, 0x10,
@@ -54,8 +53,7 @@ static const u8 rv770_smc_int_vectors[] =
  	0x03, 0x51, 0x03, 0x51
  };

-static const u8 rv730_smc_int_vectors[] =
-{
+static const u8 rv730_smc_int_vectors[] = {
  	0x08, 0x15, 0x08, 0x15,
  	0x08, 0x15, 0x08, 0x15,
  	0x08, 0x15, 0x08, 0x15,
@@ -74,8 +72,7 @@ static const u8 rv730_smc_int_vectors[] =
  	0x03, 0x56, 0x03, 0x56
  };

-static const u8 rv710_smc_int_vectors[] =
-{
+static const u8 rv710_smc_int_vectors[] = {
  	0x08, 0x04, 0x08, 0x04,
  	0x08, 0x04, 0x08, 0x04,
  	0x08, 0x04, 0x08, 0x04,
@@ -94,8 +91,7 @@ static const u8 rv710_smc_int_vectors[] =
  	0x03, 0x51, 0x03, 0x51
  };

-static const u8 rv740_smc_int_vectors[] =
-{
+static const u8 rv740_smc_int_vectors[] = {
  	0x08, 0x10, 0x08, 0x10,
  	0x08, 0x10, 0x08, 0x10,
  	0x08, 0x10, 0x08, 0x10,
@@ -114,8 +110,7 @@ static const u8 rv740_smc_int_vectors[] =
  	0x03, 0x51, 0x03, 0x51
  };

-static const u8 cedar_smc_int_vectors[] =
-{
+static const u8 cedar_smc_int_vectors[] = {
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
@@ -134,8 +129,7 @@ static const u8 cedar_smc_int_vectors[] =
  	0x04, 0xF6, 0x04, 0xF6
  };

-static const u8 redwood_smc_int_vectors[] =
-{
+static const u8 redwood_smc_int_vectors[] = {
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
@@ -154,8 +148,7 @@ static const u8 redwood_smc_int_vectors[] =
  	0x04, 0xF6, 0x04, 0xF6
  };

-static const u8 juniper_smc_int_vectors[] =
-{
+static const u8 juniper_smc_int_vectors[] = {
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
@@ -174,8 +167,7 @@ static const u8 juniper_smc_int_vectors[] =
  	0x04, 0xF6, 0x04, 0xF6
  };

-static const u8 cypress_smc_int_vectors[] =
-{
+static const u8 cypress_smc_int_vectors[] = {
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
  	0x0B, 0x05, 0x0B, 0x05,
@@ -194,8 +186,7 @@ static const u8 cypress_smc_int_vectors[] =
  	0x04, 0xF6, 0x04, 0xF6
  };

-static const u8 barts_smc_int_vectors[] =
-{
+static const u8 barts_smc_int_vectors[] = {
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
@@ -214,8 +205,7 @@ static const u8 barts_smc_int_vectors[] =
  	0x05, 0x0A, 0x05, 0x0A
  };

-static const u8 turks_smc_int_vectors[] =
-{
+static const u8 turks_smc_int_vectors[] = {
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
@@ -234,8 +224,7 @@ static const u8 turks_smc_int_vectors[] =
  	0x05, 0x0A, 0x05, 0x0A
  };

-static const u8 caicos_smc_int_vectors[] =
-{
+static const u8 caicos_smc_int_vectors[] = {
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
  	0x0C, 0x14, 0x0C, 0x14,
@@ -254,8 +243,7 @@ static const u8 caicos_smc_int_vectors[] =
  	0x05, 0x0A, 0x05, 0x0A
  };

-static const u8 cayman_smc_int_vectors[] =
-{
+static const u8 cayman_smc_int_vectors[] = {
  	0x12, 0x05, 0x12, 0x05,
  	0x12, 0x05, 0x12, 0x05,
  	0x12, 0x05, 0x12, 0x05,
