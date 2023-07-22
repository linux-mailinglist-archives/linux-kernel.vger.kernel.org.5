Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0AA75DDD4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGVRbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGVRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:31:13 -0400
Received: from so254-32.mailgun.net (so254-32.mailgun.net [198.61.254.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104A1FD9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 10:31:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690047070; x=1690054270; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=gBGdbi7zMsDc4jLtV1jMwsUxbQ0E089NfPCcUt+Wu1E=;
 b=Nyc5Ud47dz2emmmwJoKzbVFZ+ee022avYs0+M/2S5eoVUyuBSUTdrhJYRQyQJdNnfass/7aw9lRLcOPnNOQDu47tsE9aX7lzF3A92w1vHGW30XO+CwsEpshUwECW/CG4d/Cd3yDtKHeHwRVL13l2vyc0osZa7o3G2r3toAczzkZYKlARP8nfR66fv38bmzSWKzuw0Pvm3u6bZYHm4DIvJomrU9pMidXqRdf67Y0Vfebiv04fneOWj+5wppTmCACrDtKJCRgtVd/yd8eUgVkcGpaYFn9Hy75s0RnryVVHUE87jXwQuITiiOZxuUNdKKsUiqJQDJ83Ya9Y7bFvakqCFg==
X-Mailgun-Sending-Ip: 198.61.254.32
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 1b08b7c1fb5c with SMTP id
 64bc11319b55128dd86e2554 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Jul 2023 17:26:09 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: hwmon: hp-wmi-sensors: Change document title
Date:   Sat, 22 Jul 2023 10:25:14 -0700
Message-Id: <20230722172513.9324-3-james@equiv.tech>
In-Reply-To: <20230722172513.9324-1-james@equiv.tech>
References: <20230722172513.9324-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change title to "Kernel driver hp-wmi-sensors" for consistency with
most of the rest of Documentation/hwmon.
---
 Documentation/hwmon/hp-wmi-sensors.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/hp-wmi-sensors.rst b/Documentation/hwmon/hp-wmi-sensors.rst
index a6bca9aecdde..a611c6263074 100644
--- a/Documentation/hwmon/hp-wmi-sensors.rst
+++ b/Documentation/hwmon/hp-wmi-sensors.rst
@@ -2,9 +2,9 @@
 
 .. include:: <isonum.txt>
 
-===========================
-Linux HP WMI Sensors Driver
-===========================
+============================
+Kernel driver hp-wmi-sensors
+============================
 
 :Copyright: |copy| 2023 James Seo <james@equiv.tech>
 
-- 
2.39.2

