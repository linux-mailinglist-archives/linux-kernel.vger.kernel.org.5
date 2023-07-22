Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988BC75DDF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGVRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:46:19 -0400
X-Greylist: delayed 1232 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 10:46:16 PDT
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245D26B2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 10:46:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1690047975; x=1690055175; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=2ZM8uvTNkSlbDWoHgS2NyrOFq+N/5mog0L1a0g4U21Y=;
 b=C0t9MmKxdY1HrqDEkRqBsbD+FMFZkmgZBT6szcVPUma6OzMtyLmUPEmudDDQmgNoo49lTeMz+hLaJfNbbV1i5hxJplMuo78WvGrg8QSJtePNIRbFJUiSycMBCkkJzOD8Mi4Cm3XJiIGo7HxYizpjGFQ7qFXQnrsesHRbhTzQ+kN4bo1Xpc1gDUwrZykdQVx/ITxAkC6+oI0uTztwSeiGnBeTIXemfFOqHf8jxJwAibiNBH2hmWwtrfjFApbOsTDnVFinwbrYDx2GthJLQAChA/nRF/a+tFS3uP/sjy8MY3V/abv8GGvUzrtFCWXQOwII4hvLPwfleNvuFUPNC01ejA==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 1b2ddc83fb9c with SMTP id
 64bc11178dca71a24a2eda77 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Jul 2023 17:25:43 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: hp-wmi-sensors: Minor fixes
Date:   Sat, 22 Jul 2023 10:25:11 -0700
Message-Id: <20230722172513.9324-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make driver init slightly more efficient and the appearance of
generated documentation more consistent.

James Seo (2):
  hwmon: hp-wmi-sensors: Get WMI instance count from WMI driver core
  docs: hwmon: hp-wmi-sensors: Change document title

 Documentation/hwmon/hp-wmi-sensors.rst |  6 +++---
 drivers/hwmon/hp-wmi-sensors.c         | 20 +++-----------------
 2 files changed, 6 insertions(+), 20 deletions(-)


base-commit: c4be22597a36e3487474aee9b4177cc8cf780124
-- 
2.39.2

